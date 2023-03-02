from xdsl.pattern_rewriter import (PatternRewriter, PatternRewriteWalker,
                                   RewritePattern, GreedyRewritePatternApplier)
from xdsl.ir import MLContext, OpResult, Operation
from xdsl.dialects.builtin import ModuleOp
from xdsl.dialects.memref import MemRefCast, MemRefSubview, MemRefType

from xdsl.dialects.experimental.stencil import FieldType, Cast


class CastOpLowering(RewritePattern):

    def match_and_rewrite(self, op: Operation, rewriter: PatternRewriter, /):
        if (isinstance(op, Cast)):
            size_dim1 = abs(op.lb.parameters[0].data[0].value.data) + abs(
                op.ub.parameters[0].data[0].value.data)
            size_dim2 = abs(op.lb.parameters[0].data[1].value.data) + abs(
                op.ub.parameters[0].data[1].value.data)
            size_dim3 = abs(op.lb.parameters[0].data[2].value.data) + abs(
                op.ub.parameters[0].data[2].value.data)

            dynamic_dim_memref_type = MemRefType.from_element_type_and_shape(
                op.field.typ.element_type, [
                    op.field.typ.shape.data[0].value.data,
                    op.field.typ.shape.data[1].value.data,
                    op.field.typ.shape.data[2].value.data
                ])
            dynamic_dim_memref_ssa_val = OpResult(dynamic_dim_memref_type, [],
                                                  [])

            res_memref_type = MemRefType.from_element_type_and_shape(
                op.result.typ.element_type, [size_dim1, size_dim2, size_dim3])

            memref_cast = MemRefCast.build(
                operands=[dynamic_dim_memref_ssa_val],
                result_types=[res_memref_type])

            rewriter.replace_matched_op([memref_cast])

            print()


def ConvertStencilToLLMLIRPass(ctx: MLContext, module: ModuleOp):
    walker = PatternRewriteWalker(GreedyRewritePatternApplier(
        [CastOpLowering()]),
                                  walk_regions_first=True,
                                  apply_recursively=False,
                                  walk_reverse=True)
    walker.rewrite_module(module)
