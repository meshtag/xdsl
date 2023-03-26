from dataclasses import dataclass
from math import prod
from typing import TypeVar, Any
from warnings import warn

from xdsl.pattern_rewriter import (PatternRewriter, PatternRewriteWalker,
                                   RewritePattern, GreedyRewritePatternApplier,
                                   op_type_rewrite_pattern)
from xdsl.ir import BlockArgument, MLContext, Operation, OpResult, Block
from xdsl.irdl import Attribute
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

        CombinedOpOperands = consumer_op.operands
        CombinedOpLB = consumer_op.lb
        CombinedOpUB = consumer_op.ub
        print(CombinedOpUB)
        # print(CombinedOpOperands)
        # print(type(CombinedOpOperands))

        # for operand in consumer_op.operands:
        #     if (operand is not producer_op.res and operand not in CombinedOpOperands):
        #         CombinedOpOperands += tuple([operand])

        # print(CombinedOpOperands)

        # ApplyOpCheck = ApplyOp.get(CombinedOpOperands, CombinedOpLB, CombinedOpUB, Block())
        # print(ApplyOpCheck)

        # rewriter.inline_block_at_pos(ApplyOpCheck.region.blocks[0], consumer_op.region.blocks[0], 0)

        # for op in producer_op.region.blocks[0].ops:
        #     if (isinstance(op, StoreResultOp)):
        #         print("Here")
        #         rewriter.replace_matched_op([], [op.res])

        # producer_op.walk(self.WalkProducerOp(rewriter))
        # producer_op.walk(self.WalkProducerOp(self, op, rewriter))

        # i64_temp_type = TempType.from_shape([2, 3], f64)
        # temp_ssa_value = OpResult(i64_temp_type, [], [])

        # lb = IndexAttr([
        #     ArrayAttr([
        #         IntegerAttr(0, i64),
        #         IntegerAttr(0, i64),
        #         IntegerAttr(0, i64)
        #     ])
        # ])
        # ub = IndexAttr([
        #     ArrayAttr([
        #         IntegerAttr(64, i64),
        #         IntegerAttr(64, i64),
        #         IntegerAttr(64, i64)
        #     ])
        # ])

        # ApplyOpCheck = ApplyOp.get([temp_ssa_value], lb, ub, Block())
        # print(ApplyOpCheck)

    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: Operation, rewriter: PatternRewriter, /):
        if isinstance(op, ApplyOp) and super().HasSingleConsumer(
                op) and super().IsStencilInliningPossible(op):
            self.InlineProducer(op, rewriter)


def StencilInlining(ctx: MLContext, module: ModuleOp):

    the_one_pass = PatternRewriteWalker(GreedyRewritePatternApplier(
        [InliningRewrite()]),
                                        apply_recursively=False,
                                        walk_reverse=False)
    the_one_pass.rewrite_module(module)
