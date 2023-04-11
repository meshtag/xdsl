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
            if (applyop_consumers_num > 1):
                break

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

        entry_producer = producer_op.region.blocks[0]
        entry_consumer = consumer_op.region.blocks[0]

        for idx, arg in enumerate(entry_producer.args):
            arg_uses = set(arg.uses)
            for use in arg_uses:
                use.operation.replace_operand(use.index, producer_op.args[idx])
            entry_producer.erase_arg(arg)

        for idx, arg in enumerate(entry_consumer.args):
            arg_uses = set(arg.uses)
            for use in arg_uses:
                use.operation.replace_operand(use.index, consumer_op.args[idx])
            entry_consumer.erase_arg(arg)

        inlined_op_operands = list(producer_op.operands)
        for operand in list(consumer_op.operands):
            if operand not in list(
                    producer_op.res) and operand not in producer_op.operands:
                inlined_op_operands.append(operand)

        inlined_op_res_list = [
            consumer_op_res.typ for consumer_op_res in consumer_op.res
        ]

        producer_op_external_uses = []

        # Remove ReturnOp and StoreResultOp from producer which do not have another
        # use apart from the consumer_op.
        for op in producer_op.region.ops:
            if isinstance(op, ReturnOp):
                external_use_flag = 0
                conserved_return_val = []
                op_args = list(op.operands)
                for i, return_val in enumerate(op_args):
                    for use in list(producer_op.results[i].uses):
                        external_use_flag = 0
                        if not consumer_op is use.operation and not consumer_op.region.blocks[
                                0] is use.operation.parent:
                            external_use_flag = 1
                            producer_op_external_uses.append(use)
                            break
                    if external_use_flag:
                        conserved_return_val.append(return_val)
                        inlined_op_res_list.append(
                            producer_op.results[0].op.results[i].typ)
                if not external_use_flag:
                    producer_op.region.blocks[0].erase_op(op)
                else:
                    new_return_op = ReturnOp.get(conserved_return_val)
                    rewriter.replace_op(op, new_return_op)

        for op in producer_op.region.ops:
            if isinstance(op, StoreResultOp) and not len(op.results[0].uses):
                producer_op.region.blocks[0].erase_op(op)

        inlined_op_region = Region()
        inlined_op_block = Block()

        # Insert inlined op block arguments in inlined op block.
        for i, operand in enumerate(inlined_op_operands):
            rewriter.insert_block_argument(inlined_op_block, i, operand.typ)
            uses = list(operand.uses)
            for use in uses:
                use.operation.replace_operand(use.index,
                                              inlined_op_block.args[i])

        producer_op_result_traces = [
            use.operation.args[use.index] for use in producer_op.res[i].uses
            if isinstance(use.operation, ApplyOp)
            for i in range(len(producer_op.res))
        ]

        inlined_op_return_arguments = []

        # Start inlining ops depending on their use in consumer op.
        for op in consumer_op.region.ops:
            if isinstance(op,
                          AccessOp) and op.temp in producer_op_result_traces:
                for i, producer_op_unit in enumerate(producer_op.region.ops):
                    if isinstance(producer_op_unit, AccessOp):
                        producer_op_unit_clone = producer_op_unit.clone()
                        new_offset = IndexAttr.add_offsets(
                            producer_op_unit_clone.offset, op.offset)
                        new_offset_attr = IndexAttr([
                            ArrayAttr([
                                IntegerAttr(offset_val, i64)
                                for offset_val in new_offset
                            ])
                        ])
                        producer_op_unit_clone.offset = new_offset_attr
                        inlined_op_block.add_op(producer_op_unit_clone)

                        uses = list(producer_op_unit.res.uses)
                        for use in uses:
                            use.operation.replace_operand(
                                use.index, producer_op_unit_clone.res)
                    elif not isinstance(producer_op_unit, ReturnOp):
                        producer_op_unit_clone_normal_op = producer_op_unit.clone(
                        )
                        inlined_op_block.add_op(
                            producer_op_unit_clone_normal_op)

                        if isinstance(producer_op_unit, StoreResultOp):
                            uses = list(producer_op_unit.res.uses)
                            for use in uses:
                                use.operation.replace_operand(
                                    use.index,
                                    producer_op_unit_clone_normal_op.res)

                        if not isinstance(producer_op_unit, StoreResultOp):
                            use_other_than_store_or_return = 0
                            for res in producer_op_unit.results:
                                for use in res.uses:
                                    if not isinstance(
                                            use.operation,
                                            ReturnOp) and not isinstance(
                                                use.operation, StoreResultOp):
                                        use_other_than_store_or_return = 1
                                        break

                            if not use_other_than_store_or_return:
                                res_final = producer_op_unit_clone_normal_op.results[
                                    0]

                                uses = list(op.results[0].uses)
                                for use in uses:
                                    use.operation.replace_operand(
                                        use.index, res_final)
                    elif isinstance(producer_op_unit, ReturnOp):
                        inlined_op_return_arguments.extend(
                            x.op.results[0]
                            for x in list(producer_op_unit.operands))
            elif not isinstance(op, ReturnOp):
                op_clone = op.clone()
                inlined_op_block.add_op(op_clone)

                for i, res in enumerate(op.results):
                    res_uses = list(res.uses)
                    for use in res_uses:
                        use.operation.replace_operand(use.index,
                                                      op_clone.results[i])
            else:
                if not len(inlined_op_return_arguments):
                    op_clone = op.clone()
                    inlined_op_block.add_op(op_clone)
                else:
                    combined_list = [
                        *inlined_op_return_arguments, *list(op.operands)
                    ]

                    inlined_op_return = ReturnOp.get(combined_list)
                    inlined_op_block.add_op(inlined_op_return)

        # Attach inlined op block to the inlined op region as defined above.
        inlined_op_region.add_block(inlined_op_block)

        # Get the final op.
        InlinedOp = ApplyOp.get(inlined_op_operands, consumer_op.lb,
                                consumer_op.ub, inlined_op_region,
                                [inlined_op_res_list])

        rewriter.insert_op_before_matched_op([InlinedOp])

        # Replace producer op's result with inlined op's results.
        for i, use in enumerate(producer_op_external_uses):
            use.operation.replace_operand(use.index, InlinedOp.res[i])

        # Replace consumer op's result with inlined op's results.
        consumer_op_res_list = list(consumer_op.res)
        for i, consumer_op_res in enumerate(consumer_op_res_list):
            consumer_op_res_uses = list(consumer_op_res.uses)
            for use in consumer_op_res_uses:
                use.operation.replace_operand(
                    use.index,
                    InlinedOp.res[i + len(producer_op_external_uses)])

        # Remove consumer op from the IR.
        consumer_op_parent = consumer_op.parent
        consumer_op_parent.erase_op(consumer_op, False)

        # Remove producer op from the IR.
        rewriter.erase_matched_op(False)

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
