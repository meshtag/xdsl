from dataclasses import dataclass
from math import prod
from typing import TypeVar, Any
from warnings import warn

from xdsl.pattern_rewriter import (PatternRewriter, PatternRewriteWalker,
                                   RewritePattern, GreedyRewritePatternApplier,
                                   op_type_rewrite_pattern)
from xdsl.ir import BlockArgument, MLContext, Operation, OpResult, Block
from xdsl.irdl import Attribute, Region
from xdsl.dialects.builtin import ArrayAttr, FunctionType, IntegerAttr, IntegerType, ModuleOp, f64, i64
from xdsl.dialects.func import FuncOp
from xdsl.dialects.memref import MemRefType
from xdsl.dialects import memref, arith, scf, builtin, gpu

from xdsl.dialects.experimental.stencil import AccessOp, ApplyOp, CastOp, FieldType, IndexAttr, LoadOp, ReturnOp, StoreOp, StoreResultOp, TempType, ExternalLoadOp
from xdsl.utils.exceptions import VerifyException

_TypeElement = TypeVar("_TypeElement", bound=Attribute)


@dataclass
class StencilInliningPattern(RewritePattern):
    # Check if there is a single apply_op consumer for current producer apply_op.
    def HasSingleConsumer(self, producer_op: ApplyOp) -> bool:
        applyop_consumers_num = 0
        for use in producer_op.res[0].uses:
            if (isinstance(use.operation, ApplyOp)):
                applyop_consumers_num += 1

        return applyop_consumers_num == 1

    # Check if inlining is possible
    def IsStencilInliningPossible(self, producer_op: ApplyOp) -> bool:
        # Do not inline producer ops that do not store stuff.
        for use in producer_op.res[0].uses:
            if (isinstance(use.operation, StoreOp)):
                return True

        for op in producer_op.region.blocks[0].ops:
            if (isinstance(op, StoreResultOp)):
                return True

        return False

        # Not adding the case for dealing with dynamic offsets since we do not support them
        # as of now.

    def IsStencilReroutingPossible(self, producer_op: ApplyOp,
                                   consumer_op: ApplyOp) -> bool:
        return True

    def GetSingleConsumerApplyOp(self, producer_op: ApplyOp) -> ApplyOp | None:
        for use in producer_op.res[0].uses:
            if (isinstance(use.operation, ApplyOp)):
                return use.operation
        return None


@dataclass
class InliningRewrite(StencilInliningPattern):

    def InlineProducer(self, producer_op: ApplyOp, rewriter: PatternRewriter,
                       /):
        consumer_op = super().GetSingleConsumerApplyOp(producer_op)
        assert (isinstance(consumer_op, ApplyOp))

        inlined_op_operands = list(producer_op.operands)
        for operand in list(consumer_op.operands):
            if operand is not producer_op.res[
                    0] and operand not in producer_op.operands:
                inlined_op_operands.append(operand)

        # Remove ReturnOp and StoreResultOp from producer as they do not need to be inlined.
        for op in producer_op.region.ops:
            if (isinstance(op, ReturnOp)):
                producer_op.region.blocks[0].erase_op(op)
        for op in producer_op.region.ops:
            if (isinstance(op, StoreResultOp)):
                producer_op.region.blocks[0].erase_op(op)

        inlined_op_region = Region()
        inlined_op_block = Block()
        for operand in inlined_op_operands:
            rewriter.insert_block_argument(inlined_op_block,
                                           inlined_op_operands.index(operand),
                                           operand.typ)

        for op in consumer_op.region.ops:
            # Second comparison is potentially error prone
            if isinstance(op,
                          AccessOp) and op.temp.typ == producer_op.res[0].typ:
                for producer_op_unit in producer_op.region.ops:
                    if isinstance(producer_op_unit, AccessOp):
                        producer_op_unit_clone = producer_op_unit.clone()
                        new_offset = IndexAttr.add_offsets(
                            producer_op_unit_clone.offset, op.offset)
                        new_offset_attr = IndexAttr([
                            ArrayAttr([
                                IntegerAttr(new_offset[0], i64),
                                IntegerAttr(new_offset[1], i64),
                                IntegerAttr(new_offset[2], i64),
                            ])
                        ])
                        producer_op_unit_clone.offset = new_offset_attr
                        inlined_op_block.add_op(producer_op_unit_clone)
                    else:
                        producer_op_unit_clone_normal_op = producer_op_unit.clone(
                        )
                        inlined_op_block.add_op(
                            producer_op_unit_clone_normal_op)
            else:
                op_clone = op.clone()
                inlined_op_block.add_op(op_clone)

        inlined_op_region.add_block(inlined_op_block)

        # Mark consumer op as empty since its contents are already inlined.
        consumer_op.region.blocks = []

        InlinedOp = ApplyOp.get(inlined_op_operands, consumer_op.lb,
                                consumer_op.ub, inlined_op_region,
                                consumer_op.res[0].typ)

        rewriter.replace_matched_op(InlinedOp)

        # print("\n\n")
        # print(InlinedOp)

    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: ApplyOp, rewriter: PatternRewriter, /):
        if super().HasSingleConsumer(op) and super().IsStencilInliningPossible(
                op):
            self.InlineProducer(op, rewriter)


def StencilInlining(ctx: MLContext, module: ModuleOp):

    the_one_pass = PatternRewriteWalker(GreedyRewritePatternApplier(
        [InliningRewrite()]),
                                        apply_recursively=False,
                                        walk_reverse=False)
    the_one_pass.rewrite_module(module)
