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

        inlined_op_region = Region()
        for block in consumer_op.region.blocks:
            block.parent = None
            inlined_op_region.add_block(block)
        consumer_op.region.blocks = []

        # Remove ReturnOp and StoreResultOp from producer as they do not need to be inlined.
        for op in producer_op.region.ops:
            if (isinstance(op, ReturnOp)):
                producer_op.region.blocks[0].erase_op(op)
        for op in producer_op.region.ops:
            if (isinstance(op, StoreResultOp)):
                producer_op.region.blocks[0].erase_op(op)

        # parent_block = consumer_op.parent
        # parent_block.erase_op(consumer_op, False)

        # for op in inlined_op_region.blocks[0].ops:
        #     if (producer_op.res[0] in op.operands):
        #         print(op)
        #         print()
        #     print(op)
        #     print()

        # for arg in inlined_op_region.blocks[0].args:
        #     if arg is producer_op.res[0]:
        #         arg_uses = set(arg.uses)
        #         for use in arg_uses:
        #             use.operation.replace_operand(
        #                 use.index, inlined_op_region.blocks[0].args[use.index])
        #         inlined_op_region.blocks[0].erase_arg(arg)

        # for arg in inlined_op_region.blocks[0].args:
        #     rewriter.erase_block_argument(arg, False)

        # for op in inlined_op_operands:
        #     rewriter.insert_block_argument(inlined_op_region.blocks[0], inlined_op_operands.index(op), op.typ)

        # # for op in producer_op.region.blocks[0].ops:
        # #     if (isinstance(op, StoreResultOp)):
        # #         print(op.uses)

        # # print(producer_op.region.blocks[0].ops)

        # inlined_op_region.blocks[0].ops = producer_op.region.blocks[0].ops + inlined_op_region.blocks[0].ops

        InlinedOp = ApplyOp.get(inlined_op_operands, consumer_op.lb,
                                consumer_op.ub, inlined_op_region,
                                consumer_op.res[0].typ)

        # rewriter.insert_op_at_pos(InlinedOp, consumer_op.region.blocks[0], )
        rewriter.replace_matched_op(InlinedOp)

        print("\n\n")
        print(InlinedOp)
        # print("\n")
        # print("Inlined op above")
        # print("\n")

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
