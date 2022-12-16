# from xdsl.dialects.memref import *
# from xdsl.dialects.vector import *
# from xdsl.dialects.builtin import VectorType, Builtin

# # from xdsl.mlir_converter import MLIRConverter, mlir
# from xdsl.dialects.scf import Scf
# from xdsl.dialects.func import Func
# from xdsl.dialects.memref import MemRef
# from xdsl.dialects.affine import Affine
# from xdsl.dialects.arith import Arith

# from xdsl.parser import Parser
# from xdsl.ir import MLContext

# from xdsl.printer import Printer

# # Printer used to pretty-print MLIR data structures
# printer = Printer()

# def test_memref():
#     # int_attr = IntegerAttr.from_params(5, Attribute)
#     int_t = IntegerType.from_width(32)

#     print("I am here")
#     check_memref = MemRefType.from_params(int_t, ArrayAttr.from_list(
#             [IntegerAttr.from_int_and_width(5, 64), IntegerAttr.from_int_and_width(7, 64)]))
#     print(type(check_memref))
#     print("I am here as well")

#     printer.print_attribute(check_memref)
#     print()

# # def convert_and_verify(test_prog: str):
# #     ctx = MLContext()
# #     ctx.register_dialect(Builtin)
# #     ctx.register_dialect(Func)
# #     ctx.register_dialect(Affine)
# #     ctx.register_dialect(Arith)
# #     ctx.register_dialect(Scf)
# #     ctx.register_dialect(MemRef)

# #     parser = Parser(ctx, test_prog)
# #     module = parser.parse_op()
# #     module.verify()

# #     converter = MLIRConverter(ctx)
# #     with mlir.ir.Context() as mlir_ctx:
# #         mlir_ctx.allow_unregistered_dialects = True
# #         with mlir.ir.Location.unknown(mlir_ctx):
# #             mlir_prog = converter.convert_op(module)
# #             print(mlir_prog)
# #             assert (mlir_prog.verify())

# def test_vector():
#     int_t = IntegerType.from_width(32)

#     print("I am here vector")
    
#     check_vector = VectorType.from_params(int_t, ArrayAttr.from_list(
#             [IntegerAttr.from_int_and_width(5, 64), IntegerAttr.from_int_and_width(7, 64)]))
#     print(type(check_vector))
#     # check_vector.load

#     print("I am here as well vector")

#     printer.print_attribute(check_vector)
#     print()

# # test_memref()
# test_vector()
