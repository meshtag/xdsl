from xdsl.irdl import VarOperandDef
from xdsl.irdl import OperandDef, ResultDef
from xdsl.dialects.arith import Constant
from xdsl.irdl import irdl_op_definition
from xdsl.ir import Operation
from xdsl.dialects.builtin import *
from xdsl.printer import Printer
from xdsl.irdl import AttrSizedOperandSegments

# Printer used to pretty-print MLIR data structures
printer = Printer()

@irdl_op_definition
class AddVariadicOp2(Operation):
    name: str = "add_variadic"
    ops1 = VarOperandDef(i32)
    ops2 = VarOperandDef(i32)
    res = ResultDef(i32)

    irdl_options = [AttrSizedOperandSegments()]

i32_ssa_var = Constant.from_attr(IntegerAttr.from_int_and_width(62, 32), i32)
add_op2 = AddVariadicOp2.build(operands=[[i32_ssa_var] * 2, [i32_ssa_var]], result_types=[i32],
                               attributes={"operand_segment_sizes": VectorType.from_type_and_list(i32, [2, 1])})
print("Length of add_op2.ops1:", len(add_op2.ops1))
print("Length of add_op2.ops2:", len(add_op2.ops2))
