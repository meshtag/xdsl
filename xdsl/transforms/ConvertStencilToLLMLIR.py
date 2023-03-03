from xdsl.pattern_rewriter import (PatternRewriter, PatternRewriteWalker,
                                   RewritePattern, GreedyRewritePatternApplier)
from xdsl.ir import MLContext, OpResult, Operation
from xdsl.dialects.builtin import ModuleOp
from xdsl.dialects.func import FuncOp
from xdsl.dialects.memref import MemRefCast, MemRefSubview, MemRefType

from xdsl.dialects.experimental.stencil import FieldType, Cast


def GetMemRefFromField(inputFieldType : FieldType) -> MemRefType:
    memref_shape = []
    for i in range(len(inputFieldType.parameters[0].data)):
        memref_shape.append(inputFieldType.parameters[0].data[i].value.data)

    return MemRefType.from_element_type_and_shape(inputFieldType.element_type, memref_shape)


class StencilTypeConversionLowering(RewritePattern):

    def match_and_rewrite(self, op: Operation, rewriter: PatternRewriter, /):
        if (isinstance(op, FuncOp)):
            for i in range(len(op.body.blocks[0].args)):
                memref_type_equiv = GetMemRefFromField(op.function_type.parameters[0].data[i])
                rewriter.modify_block_argument_type(op.body.blocks[0].args[i], memref_type_equiv)
                op.function_type.parameters[0].data[i] = memref_type_equiv


class CastOpLowering(RewritePattern):

    def match_and_rewrite(self, op: Operation, rewriter: PatternRewriter, /):
        if (isinstance(op, Cast)):
            size_dim1 = abs(op.lb.parameters[0].data[0].value.data) + abs(
                op.ub.parameters[0].data[0].value.data)
            size_dim2 = abs(op.lb.parameters[0].data[1].value.data) + abs(
                op.ub.parameters[0].data[1].value.data)
            size_dim3 = abs(op.lb.parameters[0].data[2].value.data) + abs(
                op.ub.parameters[0].data[2].value.data)

            res_memref_type = MemRefType.from_element_type_and_shape(
                op.result.typ.element_type, [size_dim1, size_dim2, size_dim3])

            dynamic_dim_memref_type = GetMemRefFromField(op.field.typ)
            dynamic_dim_memref = OpResult(dynamic_dim_memref_type, [], [])

            memref_cast = MemRefCast.build(
                operands=[dynamic_dim_memref],
                result_types=[res_memref_type])
            print(memref_cast)
            print("\n")
            print(op.field)
            print("\n")
            print(op.result)
            print("\n\n\n")

            # op.field = GetMemRefFromField(op.field.typ)

            # rewriter.replace_op(op, memref_cast)


def ConvertStencilToLLMLIRPass(ctx: MLContext, module: ModuleOp):
    walker = PatternRewriteWalker(GreedyRewritePatternApplier(
        [ 
         CastOpLowering()]),
                                  walk_regions_first=True,
                                  apply_recursively=False,
                                  walk_reverse=True)
    walker.rewrite_module(module)
