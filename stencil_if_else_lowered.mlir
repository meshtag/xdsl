"builtin.module"() ({
  "func.func"() ({
  ^0(%0 : f64, %1 : memref<?x?x?xf64>):
    %2 = "memref.cast"(%1) : (memref<?x?x?xf64>) -> memref<70x70x70xf64>
    %3 = "arith.constant"() {"value" = 0 : index} : () -> index
    %4 = "arith.constant"() {"value" = 1 : index} : () -> index
    %5 = "arith.constant"() {"value" = 64 : index} : () -> index
    %6 = "arith.constant"() {"value" = 64 : index} : () -> index
    %7 = "arith.constant"() {"value" = 60 : index} : () -> index
    "scf.parallel"(%3, %3, %3, %5, %6, %7, %4, %4, %4) ({
    ^1(%8 : index, %9 : index, %10 : index):
      %11 = "arith.constant"() {"value" = 1.0 : f64} : () -> f64
      %12 = "arith.addf"(%0, %11) : (f64, f64) -> f64
      %true = "arith.constant"() {"value" = true} : () -> i1
      %13 = "scf.if"(%true) ({
        "scf.yield"(%11) : (f64) -> ()
      }, {
        "scf.yield"(%12) : (f64) -> ()
      }) : (i1) -> f64
      %14 = "arith.constant"() {"value" = 3 : index} : () -> index
      %15 = "arith.constant"() {"value" = 3 : index} : () -> index
      %16 = "arith.constant"() {"value" = 3 : index} : () -> index
      %17 = "arith.addi"(%8, %14) : (index, index) -> index
      %18 = "arith.addi"(%9, %15) : (index, index) -> index
      %19 = "arith.addi"(%10, %16) : (index, index) -> index
      "memref.store"(%12, %2, %17, %18, %19) : (f64, memref<70x70x70xf64>, index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) {"operand_segment_sizes" = array<i32: 3, 3, 3, 0>} : (index, index, index, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) {"function_type" = (f64, memref<?x?x?xf64>) -> (), "sym_name" = "stencil_float64_arg"} : () -> ()
}) : () -> ()


