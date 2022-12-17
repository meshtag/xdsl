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
    res: Annotated[OpResult, ResultDef(VectorType)]

    # TODO varargs for indexing, which must match the vector dimensions
    # Problem: vector dimensions require variadic type parameters,
    # which is subject to change

    # Add variable vector length parameter feature

    def verify_(self):
        # if self.memref.typ.element_type != self.res.typ:
        #     raise Exception(
        #         "expected return type to match the Vector element type")

        if self.memref.typ.get_num_dims() != len(self.indices):
            raise Exception("expected an index for each dimension")

    @staticmethod
    def get(ref: SSAValue | Operation,
            indices: List[SSAValue | Operation]) -> Load:
        return Load.build(operands=[ref, indices],
                          result_types=[SSAValue.get(ref).typ.element_type])

@irdl_op_definition
class Store(Operation):
    name = "vector.store"
    vector: Annotated[SSAValue, OperandDef(VectorType)]
    memref: Annotated[SSAValue, OperandDef(MemRefType)]
    indices: Annotated[list[SSAValue], VarOperandDef(IndexType)]

    # Add variable vector length parameter feature

    def verify_(self):
        # if self.memref.typ.element_type != self.value.typ:
        #     raise Exception(
        #         "Expected value type to match the MemRef element type")

        if self.memref.typ.get_num_dims() != len(self.indices):
            raise Exception("Expected an index for each dimension")

    @staticmethod
    def get(vector: Operation | SSAValue, ref: Operation | SSAValue,
            indices: List[Operation | SSAValue]) -> Store:
        return Store.build(operands=[vector, ref, indices])

@irdl_op_definition
class Fma(Operation):
    name = "vector.fma"
    vector1: Annotated[SSAValue, OperandDef(VectorType)]
    vector2: Annotated[SSAValue, OperandDef(VectorType)]
    vector3: Annotated[SSAValue, OperandDef(VectorType)]
    res: Annotated[OpResult, ResultDef(VectorType)]

    def verify_(self):
        if self.vector1.typ.element_type != self.vector2.typ.element_type or self.vector2.typ.element_type != self.vector3.typ.element_type or self.vector3.typ.element_type != self.res.typ.element_type:
            raise Exception(
                "All vectors must have the same element type.")

        if self.vector1.typ.get_num_dims() != self.vector2.typ.get_num_dims() or self.vector2.typ.get_num_dims() != self.vector3.typ.get_num_dims() or self.vector3.typ.get_num_dims() != self.res.typ.get_num_dims():
            raise Exception("All vectors must have same number of dimensions.")

    @staticmethod
    def get(vector1: Operation | SSAValue, vector2: Operation | SSAValue,
            vector3: Operation | SSAValue) -> Fma:
        return Fma.build(operands=[vector1, vector2, vector3])

Vector = Dialect([Load, Store, Fma], [])
