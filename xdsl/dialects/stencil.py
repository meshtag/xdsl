from __future__ import annotations

from typing import Annotated, TypeVar, Generic, Sequence, cast, List

from xdsl.dialects.builtin import (ParametrizedAttribute, ParameterDef, ArrayAttr, AnyIntegerAttr, IntegerAttr, IntegerType)
from xdsl.dialects.experimental.stencil import IndexAttr
from xdsl.ir import OpResult, SSAValue, Operation, Attribute, Dialect, TypeAttribute
from xdsl.irdl import (irdl_op_definition, IRDLOperation, Operand, OpAttr, irdl_attr_definition)
from xdsl.utils.exceptions import VerifyException
from xdsl.utils.hints import isa


_FieldTypeVar = TypeVar("_FieldTypeVar", bound=Attribute)


@irdl_attr_definition
class FieldType(Generic[_FieldTypeVar], ParametrizedAttribute, TypeAttribute):
    name = "stencil.field"

    shape: ParameterDef[ArrayAttr[AnyIntegerAttr]]
    element_type: ParameterDef[_FieldTypeVar]

    def get_num_dims(self) -> int:
        return len(self.shape.data)

    def get_shape(self) -> List[int]:
        return [i.value.data for i in self.shape.data]

    def verify(self):
        if self.get_num_dims() <= 0:
            raise VerifyException(
                f"Number of dimensions for desired stencil must be greater than zero."
            )

    def __init__(
        self,
        shape: ArrayAttr[AnyIntegerAttr] | Sequence[AnyIntegerAttr] | Sequence[int],
        typ: _FieldTypeVar
    ) -> None:
        if isinstance(shape, ArrayAttr):
            super().__init__([shape, typ])

        # cast to list
        shape = cast(list[AnyIntegerAttr] | list[int], shape)

        if len(shape) > 0 and isa(shape[0], list[AnyIntegerAttr]):
            super().__init__([ArrayAttr(shape), typ]) # type: ignore
        shape = cast(list[int], shape)
        super().__init__([ArrayAttr([IntegerAttr[IntegerType](d, 64) for d in shape]), typ])


@irdl_op_definition
class CastOp(IRDLOperation):
    """
    This operation casts dynamically shaped input fields to statically shaped fields.

    Example:
        %0 = stencil.cast %in ([-3, -3, 0] : [67, 67, 60]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<70x70x60xf64> # noqa
    """

    name: str = "stencil.cast"
    field: Annotated[Operand, FieldType]
    lb: OpAttr[IndexAttr]
    ub: OpAttr[IndexAttr]
    result: Annotated[OpResult, FieldType]

    @staticmethod
    def get(
        field: SSAValue | Operation,
        lb: IndexAttr,
        ub: IndexAttr,
        res_type: FieldType[_FieldTypeVar] | FieldType[Attribute] | None = None,
    ) -> CastOp:
        """ """
        field_ssa = SSAValue.get(field)
        assert isa(field_ssa.typ, FieldType[Attribute])
        if res_type is None:
            res_type = FieldType(
                tuple(ub_elm - lb_elm for lb_elm, ub_elm in zip(lb, ub)),
                field_ssa.typ.element_type,
            )
        return CastOp.build(
            operands=[field],
            attributes={"lb": lb, "ub": ub},
            result_types=[res_type],
        )

    def verify_(self) -> None:
        # this should be fine, verify() already checks them:
        assert isa(self.field.typ, FieldType[Attribute])
        assert isa(self.result.typ, FieldType[Attribute])

        if self.field.typ.element_type != self.result.typ.element_type:
            raise VerifyException(
                "Input and output fields have different element types"
            )

        if not len(self.lb) == len(self.ub):
            raise VerifyException("lb and ub must have the same dimensions")

        if not len(self.field.typ.shape) == len(self.lb):
            raise VerifyException("Input type and bounds must have the same dimensions")

        if not len(self.result.typ.shape) == len(self.ub):
            raise VerifyException(
                "Result type and bounds must have the same dimensions"
            )

        for i, (in_attr, lb, ub, out_attr) in enumerate(
            zip(
                self.field.typ.shape,
                self.lb,
                self.ub,
                self.result.typ.shape,
            )
        ):
            in_: int = in_attr.value.data
            out: int = out_attr.value.data

            if ub - lb != out:
                raise VerifyException(
                    "Bound math doesn't check out in dimensions {}! {} - {} != {}".format(
                        i, ub, lb, out
                    )
                )

            if in_ != -1:
                # TODO: find out if this is too strict
                raise VerifyException("Input must be dynamically shaped")


Stencil = Dialect([CastOp], [FieldType])
