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
        # print(op.sym_name)
        # print(op)
        # print(type(op))
        # print("\n\n\n\n")

        if (isinstance(op, FuncOp)):
            for i in range(len(op.body.blocks[0].args)):
                memref_type_equiv = GetMemRefFromField(op.function_type.parameters[0].data[i])
                rewriter.modify_block_argument_type(op.body.blocks[0].args[i], memref_type_equiv)
                op.function_type.parameters[0].data[i] = memref_type_equiv


        # for i in range(len(op.operands)):
        #     # print(isinstance(op.operands[i].typ, FieldType))
        #     if (isinstance(op.operands[i].typ, FieldType)):
        #         memref_shape = []
        #         # print(len(op.operands[i].typ.parameters[0].data))
        #         for j in range(len(op.operands[i].typ.parameters[0].data)):
        #             memref_shape.append(
        #                 op.operands[i].typ.parameters[0].data[j].value.data)
        #         memref_type = MemRefType.from_element_type_and_shape(
        #             op.operands[i].typ.element_type, memref_shape)
        #         # print(memref_type)
        #         rewriter.modify_block_argument_type(op, memref_type)

        # print("\n\n\n")


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


def ConvertStencilToLLMLIRPass(ctx: MLContext, module: ModuleOp):
    walker = PatternRewriteWalker(GreedyRewritePatternApplier(
        [StencilTypeConversionLowering()]),
                                  walk_regions_first=True,
                                  apply_recursively=False,
                                  walk_reverse=True)
    walker.rewrite_module(module)
