from __future__ import annotations

from dataclasses import dataclass
from typing import Annotated, TypeVar, Optional, List, TypeAlias

from xdsl.dialects.builtin import (IntegerAttr, IndexType, ArrayAttr,
                                   IntegerType, FlatSymbolRefAttr, StringAttr,
                                   DenseIntOrFPElementsAttr, VectorType)
from xdsl.dialects.memref import MemRefType
from xdsl.ir import MLIRType, Operation, SSAValue, ParametrizedAttribute, Dialect, OpResult
from xdsl.irdl import (irdl_attr_definition, irdl_op_definition, builder,
                       ParameterDef, Generic, Attribute, AnyAttr, OperandDef,
                       VarOperandDef, ResultDef, AttributeDef,
                       AttrSizedOperandSegments, OptAttributeDef)

AnyIntegerAttr: TypeAlias = IntegerAttr[IntegerType | IndexType]

@irdl_op_definition
class Load(Operation):
    name = "vector.load"
    memref: Annotated[SSAValue, OperandDef(MemRefType)]
    indices: Annotated[list[SSAValue], VarOperandDef(IndexType)]
    res: Annotated[OpResult, ResultDef(AnyAttr())]

    # TODO varargs for indexing, which must match the vector dimensions
    # Problem: vector dimensions require variadic type parameters,
    # which is subject to change

    # Add variable vector length parameter feature

    def verify_(self):
        if self.memref.typ.element_type != self.res.typ:
            raise Exception(
                "expected return type to match the Vector element type")

        if self.memref.typ.get_num_dims() != len(self.indices):
            raise Exception("expected an index for each dimension")

    @staticmethod
    def get(ref: SSAValue | Operation,
            indices: List[SSAValue | Operation]) -> Load:
        return Load.build(operands=[ref, indices],
                          result_types=[SSAValue.get(ref).typ.element_type])



Vector = Dialect([Load], [])
