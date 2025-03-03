from typing import cast

from xdsl.dialects import riscv
from xdsl.dialects.builtin import IntegerAttr
from xdsl.ir.core import OpResult
from xdsl.pattern_rewriter import (
    PatternRewriter,
    RewritePattern,
    op_type_rewrite_pattern,
)


class RemoveRedundantMv(RewritePattern):
    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: riscv.MVOp, rewriter: PatternRewriter) -> None:
        if (
            op.rd.type == op.rs.type
            and isinstance(op.rd.type, riscv.RISCVRegisterType)
            and op.rd.type.is_allocated
        ):
            rewriter.replace_matched_op([], [op.rs])


class RemoveRedundantFMv(RewritePattern):
    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: riscv.FMVOp, rewriter: PatternRewriter) -> None:
        if (
            op.rd.type == op.rs.type
            and isinstance(op.rd.type, riscv.RISCVRegisterType)
            and op.rd.type.is_allocated
        ):
            rewriter.replace_matched_op([], [op.rs])


class MultiplyImmediates(RewritePattern):
    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: riscv.MulOp, rewriter: PatternRewriter) -> None:
        if (
            isinstance(op.rs1, OpResult)
            and isinstance(op.rs1.op, riscv.LiOp)
            and isinstance(op.rs1.op.immediate, IntegerAttr)
            and isinstance(op.rs2, OpResult)
            and isinstance(op.rs2.op, riscv.LiOp)
            and isinstance(op.rs2.op.immediate, IntegerAttr)
        ):
            rd = cast(riscv.IntRegisterType, op.rd.type)
            rewriter.replace_matched_op(
                riscv.LiOp(
                    op.rs1.op.immediate.value.data * op.rs2.op.immediate.value.data,
                    rd=rd,
                )
            )


class AddImmediates(RewritePattern):
    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: riscv.AddOp, rewriter: PatternRewriter) -> None:
        lhs: int | None = None
        rhs: int | None = None
        if (
            isinstance(op.rs1, OpResult)
            and isinstance(op.rs1.op, riscv.LiOp)
            and isinstance(op.rs1.op.immediate, IntegerAttr)
        ):
            lhs = op.rs1.op.immediate.value.data

        if (
            isinstance(op.rs2, OpResult)
            and isinstance(op.rs2.op, riscv.LiOp)
            and isinstance(op.rs2.op.immediate, IntegerAttr)
        ):
            rhs = op.rs2.op.immediate.value.data

        rd = cast(riscv.IntRegisterType, op.rd.type)

        match (lhs, rhs):
            case int(), None:
                rewriter.replace_matched_op(
                    riscv.AddiOp(
                        op.rs2,
                        lhs,
                        rd=rd,
                        comment=op.comment,
                    )
                )
            case None, int():
                rewriter.replace_matched_op(
                    riscv.AddiOp(
                        op.rs1,
                        rhs,
                        rd=rd,
                        comment=op.comment,
                    )
                )
            case int(), int():
                rewriter.replace_matched_op(
                    riscv.LiOp(lhs + rhs, rd=rd, comment=op.comment)
                )
            case _:
                pass


class ShiftLeftImmediate(RewritePattern):
    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: riscv.SlliOp, rewriter: PatternRewriter) -> None:
        if (
            isinstance(op.rs1, OpResult)
            and isinstance(op.rs1.op, riscv.LiOp)
            and isinstance(op.rs1.op.immediate, IntegerAttr)
            and isinstance(op.immediate, IntegerAttr)
        ):
            rd = cast(riscv.IntRegisterType, op.rd.type)
            rewriter.replace_matched_op(
                riscv.LiOp(
                    op.rs1.op.immediate.value.data << op.immediate.value.data, rd=rd
                )
            )


class LoadWordWithKnownOffset(RewritePattern):
    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: riscv.LwOp, rewriter: PatternRewriter) -> None:
        if (
            isinstance(op.rs1, OpResult)
            and isinstance(op.rs1.op, riscv.AddiOp)
            and isinstance(op.rs1.op.immediate, IntegerAttr)
            and isinstance(op.immediate, IntegerAttr)
        ):
            rd = cast(riscv.IntRegisterType, op.rd.type)
            rewriter.replace_matched_op(
                riscv.LwOp(
                    op.rs1.op.rs1,
                    op.rs1.op.immediate.value.data + op.immediate.value.data,
                    rd=rd,
                    comment=op.comment,
                )
            )


class StoreWordWithKnownOffset(RewritePattern):
    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: riscv.SwOp, rewriter: PatternRewriter) -> None:
        if (
            isinstance(op.rs1, OpResult)
            and isinstance(op.rs1.op, riscv.AddiOp)
            and isinstance(op.rs1.op.immediate, IntegerAttr)
        ):
            rewriter.replace_matched_op(
                riscv.SwOp(
                    op.rs1.op.rs1,
                    op.rs2,
                    op.rs1.op.immediate.value.data + op.immediate.value.data,
                    comment=op.comment,
                )
            )


class LoadFloatWordWithKnownOffset(RewritePattern):
    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: riscv.FLwOp, rewriter: PatternRewriter) -> None:
        if (
            isinstance(op.rs1, OpResult)
            and isinstance(op.rs1.op, riscv.AddiOp)
            and isinstance(op.rs1.op.immediate, IntegerAttr)
            and isinstance(op.immediate, IntegerAttr)
        ):
            rd = cast(riscv.FloatRegisterType, op.rd.type)
            rewriter.replace_matched_op(
                riscv.FLwOp(
                    op.rs1.op.rs1,
                    op.rs1.op.immediate.value.data + op.immediate.value.data,
                    rd=rd,
                    comment=op.comment,
                )
            )


class StoreFloatWordWithKnownOffset(RewritePattern):
    @op_type_rewrite_pattern
    def match_and_rewrite(self, op: riscv.FSwOp, rewriter: PatternRewriter) -> None:
        if (
            isinstance(op.rs1, OpResult)
            and isinstance(op.rs1.op, riscv.AddiOp)
            and isinstance(op.rs1.op.immediate, IntegerAttr)
        ):
            rewriter.replace_matched_op(
                riscv.FSwOp(
                    op.rs1.op.rs1,
                    op.rs2,
                    op.rs1.op.immediate.value.data + op.immediate.value.data,
                    comment=op.comment,
                )
            )
