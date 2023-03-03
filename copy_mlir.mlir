"builtin.module"() ({
  "func.func"() ({
  ^0(%0 : !stencil.field<[-1 : i32, -1 : i32, -1 : i32], f64>, %1 : !stencil.field<[-1 : i32, -1 : i32, -1 : i32], f64>):
    %2 = "stencil.cast"(%0) {"lb" = #stencil.index<[-4 : i32, -4 : i32, -4 : i32]>, "ub" = #stencil.index<[68 : i32, 68 : i32, 68 : i32]>} : (!stencil.field<[-1 : i32, -1 : i32, -1 : i32], f64>) -> !stencil.field<[72 : i32, 72 : i32, 72 : i32], f64>
    "func.return"() : () -> ()
  }) {"sym_name" = "stencil_copy", "function_type" = (!stencil.field<[-1 : i32, -1 : i32, -1 : i32], f64>, !stencil.field<[-1 : i32, -1 : i32, -1 : i32], f64>) -> (), "sym_visibility" = "private"} : () -> ()
}) : () -> ()

