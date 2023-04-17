"builtin.module"() ({
  "func.func"() ({
  ^0(%0 : f64, %1 : !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>):
    %2 = "stencil.cast"(%1) {"lb" = #stencil.index<[-3 : i64, -3 : i64, -3 : i64]>, "ub" = #stencil.index<[67 : i64, 67 : i64, 67 : i64]>} : (!stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>) -> !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>

    %3 = "stencil.apply"(%0) ({
    ^1(%4 : f64):
      %5 = "arith.constant"() {"value" = 1.0 : f64} : () -> f64
      %6 = "arith.addf"(%4, %5) : (f64, f64) -> f64
      "stencil.return"(%6) : (f64) -> ()
    }) : (f64) -> !stencil.temp<[-1 : i64, -1 : i64, -1 : i64], f64>

    %4 = "stencil.apply"(%3) ( {
    ^bb0(%arg2: !stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>):  // no predecessors
      %5 = "stencil.access"(%arg2) {"offset" = #stencil.index<[-1 : i64, 0 : i64, 0 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> f64
      %6 = "stencil.access"(%arg2) {"offset" = #stencil.index<[1 : i64, 0 : i64, 0 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> f64
      %7 = "arith.addf"(%5, %6) : (f64, f64) -> f64
      %8 = "stencil.store_result"(%7) : (f64) -> !stencil.result<f64>
      "stencil.return"(%8) : (!stencil.result<f64>) -> ()
    }) {"lb" = #stencil.index<[1 : i64, 2 : i64, 3 : i64]>, "ub" = #stencil.index<[65 : i64, 66 : i64, 63 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> !stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>

    "stencil.store"(%4, %2) {"lb" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>, "ub" = #stencil.index<[64 : i64, 64 : i64, 60 : i64]>} : (!stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>, !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>) -> ()
    "stencil.store"(%3, %2) {"lb" = #stencil.index<[1 : i64, 2 : i64, 3: i64]>, "ub" = #stencil.index<[65 : i64, 66 : i64, 63 : i64]>} : (!stencil.temp<[-1 : i64, -1 : i64, -1 : i64], f64>, !stencil.field<[64 : i64, 64 : i64, 60 : i64], f64>) -> ()

    "func.return"() : () -> ()
  }) {"function_type" = (f64, !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>) -> (), "sym_name" = "stencil_float64_arg"} : () -> ()
}) : () -> ()
