from typing import Annotated

from xdsl.ir import *
from xdsl.irdl import *
from xdsl.printer import Printer
from xdsl.dialects.builtin import *
from xdsl.dialects.arith import *
from xdsl.dialects.scf import *
from xdsl.dialects.experimental.stencil import *
from xdsl.pattern_rewriter import *

printer = Printer()

field_type_var = OpResult(FieldType.from_shape([1, 2]), [1], [2])
temp_type_var = TempType.from_shape([3, 4])

l = Load.build(operands=[field_type_var], result_types=[temp_type_var])

printer.print_ssa_value(field_type_var)
printer.print_op(l)
