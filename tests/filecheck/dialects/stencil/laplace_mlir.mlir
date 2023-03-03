"module"() ( {
  "func"() ( {
  ^bb0(%arg0: !stencil.field<72x72x72xf64>, %arg1: !stencil.field<72x72x72xf64>):  // no predecessors
    %0 = "stencil.cast"(%arg0) {lb = [-4, -4, -4], ub = [68, 68, 68]} : (!stencil.field<72x72x72xf64>) -> !stencil.field<72x72x72xf64>
    %1 = "stencil.cast"(%arg1) {lb = [-4, -4, -4], ub = [68, 68, 68]} : (!stencil.field<72x72x72xf64>) -> !stencil.field<72x72x72xf64>
    %2 = "stencil.load"(%0) {lb = [-1, -1, 0], ub = [65, 65, 64]} : (!stencil.field<72x72x72xf64>) -> !stencil.temp<66x66x64xf64>
    %3 = "stencil.apply"(%2) ( {
    ^bb0(%arg2: !stencil.temp<66x66x64xf64>):  // no predecessors
      %4 = "stencil.access"(%arg2) {offset = [-1, 0, 0]} : (!stencil.temp<66x66x64xf64>) -> f64
      %5 = "stencil.access"(%arg2) {offset = [1, 0, 0]} : (!stencil.temp<66x66x64xf64>) -> f64
      %6 = "stencil.access"(%arg2) {offset = [0, 1, 0]} : (!stencil.temp<66x66x64xf64>) -> f64
      %7 = "stencil.access"(%arg2) {offset = [0, -1, 0]} : (!stencil.temp<66x66x64xf64>) -> f64
      %8 = "stencil.access"(%arg2) {offset = [0, 0, 0]} : (!stencil.temp<66x66x64xf64>) -> f64
      %9 = "std.addf"(%4, %5) : (f64, f64) -> f64
      %10 = "std.addf"(%6, %7) : (f64, f64) -> f64
      %11 = "std.addf"(%9, %10) : (f64, f64) -> f64
      %cst = "std.constant"() {value = -4.000000e+00 : f64} : () -> f64
      %12 = "std.mulf"(%8, %cst) : (f64, f64) -> f64
      %13 = "std.addf"(%12, %11) : (f64, f64) -> f64
      %14 = "stencil.store_result"(%13) : (f64) -> !stencil.result<f64>
      "stencil.return"(%14) : (!stencil.result<f64>) -> ()
    }) {lb = [0, 0, 0], ub = [64, 64, 64]} : (!stencil.temp<66x66x64xf64>) -> !stencil.temp<64x64x64xf64>
    "stencil.store"(%3, %1) {lb = [0, 0, 0], ub = [64, 64, 64]} : (!stencil.temp<64x64x64xf64>, !stencil.field<72x72x72xf64>) -> ()
    "std.return"() : () -> ()
  }) {stencil.program, sym_name = "laplace", type = (!stencil.field<72x72x72xf64>, !stencil.field<72x72x72xf64>) -> ()} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()

