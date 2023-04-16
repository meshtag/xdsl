"builtin.module"() ({
  "func.func"() ({
  ^0(%arg0 : !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>, %arg1 : !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>, %arg2 : !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>):
    %0 = "stencil.cast"(%arg0) {"lb" = #stencil.index<[-3 : i64, -3 : i64, -3 : i64]>, "ub" = #stencil.index<[67 : i64, 67 : i64, 67 : i64]>} : (!stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>) -> !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>
    %1 = "stencil.cast"(%arg1) {"lb" = #stencil.index<[-3 : i64, -3 : i64, -3 : i64]>, "ub" = #stencil.index<[67 : i64, 67 : i64, 67 : i64]>} : (!stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>) -> !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>
    %2 = "stencil.cast"(%arg2) {"lb" = #stencil.index<[-3 : i64, -3 : i64, -3 : i64]>, "ub" = #stencil.index<[67 : i64, 67 : i64, 67 : i64]>} : (!stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>) -> !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>
    %3 = "stencil.load"(%0) {"lb" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>, "ub" = #stencil.index<[66 : i64, 66 : i64, 63 : i64]>} : (!stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>) -> !stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>
    %4, %5 = "stencil.apply"(%3) ({
    ^1(%6 : !stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>):
      %7 = "stencil.access"(%6) {"offset" = #stencil.index<[-1 : i64, 0 : i64, 0 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> f64
      %8 = "stencil.access"(%6) {"offset" = #stencil.index<[1 : i64, 0 : i64, 0 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> f64
      %9 = "arith.addf"(%7, %8) {"fastmath" = #arith.fastmath<none>} : (f64, f64) -> f64
      %10 = "stencil.store_result"(%9) : (f64) -> !stencil.result<f64>
      %11 = "stencil.store_result"(%8) : (f64) -> !stencil.result<f64>
      "stencil.return"(%10, %11) : (!stencil.result<f64>, !stencil.result<f64>) -> ()
    }) {"lb" = #stencil.index<[1 : i64, 2 : i64, 3 : i64]>, "ub" = #stencil.index<[65 : i64, 66 : i64, 63 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> (!stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>, !stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>)
    %6, %7 = "stencil.apply"(%3, %4) ({
    ^2(%12 : !stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>, %13 : !stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>):
      %14 = "stencil.access"(%12) {"offset" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> f64
      %15 = "stencil.access"(%13) {"offset" = #stencil.index<[1 : i64, 2 : i64, 3 : i64]>} : (!stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>) -> f64
      %16 = "arith.subf"(%14, %15) {"fastmath" = #arith.fastmath<none>} : (f64, f64) -> f64
      %17 = "stencil.store_result"(%16) : (f64) -> !stencil.result<f64>
      %18 = "stencil.store_result"(%15) : (f64) -> !stencil.result<f64>
      "stencil.return"(%17, %18) : (!stencil.result<f64>, !stencil.result<f64>) -> ()
    }) {"lb" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>, "ub" = #stencil.index<[64 : i64, 64 : i64, 60 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>, !stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>) -> (!stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>, !stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>)
    "stencil.store"(%6, %1) {"lb" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>, "ub" = #stencil.index<[64 : i64, 64 : i64, 60 : i64]>} : (!stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>, !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>) -> ()
    "stencil.store"(%7, %2) {"lb" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>, "ub" = #stencil.index<[64 : i64, 64 : i64, 60 : i64]>} : (!stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>, !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>) -> ()
    "stencil.store"(%5, %0) {"lb" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>, "ub" = #stencil.index<[64 : i64, 64 : i64, 60 : i64]>} : (!stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>, !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>) -> ()
    "func.return"() : () -> ()
  }) {"function_type" = (!stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>, !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>, !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>) -> (), "sym_name" = "simple_stencil_inlining"} : () -> ()
}) : () -> ()
