"builtin.module"() ({
  "memref.global"() {"sym_name" = "g", "type" = memref<1xindex>, "initial_value" = dense<[0]> : tensor<1xindex>, "sym_visibility" = "public"} : () -> ()
  "func.func"() ({
    %0 = "memref.get_global"() {"name" = @g} : () -> memref<1xindex>
    %1 = "arith.constant"() {"value" = 0 : index} : () -> index
    %2 = "memref.alloca"() {"alignment" = 0 : i64, "operand_segment_sizes" = array<i32: 0, 0>} : () -> memref<1xindex>
    %3 = "arith.constant"() {"value" = 42 : index} : () -> index
    "memref.store"(%3, %2, %1) : (index, memref<1xindex>, index) -> ()
    %4 = "memref.load"(%2, %1) : (memref<1xindex>, index) -> index
    %5 = "memref.alloc"() {"alignment" = 0 : i64, "operand_segment_sizes" = array<i32: 0, 0>} : () -> memref<10x2xindex>
    "memref.store"(%3, %5, %3, %4) : (index, memref<10x2xindex>, index, index) -> ()
    // %6 = "memref.subview"(%5) {"static_offsets" = array<i64: 1, i64: 1>, "static_sizes" = array<i64: 1>, "static_strides" = array<i64: 1>, "operand_segment_sizes" = array<i32: 1, 0, 0, 0>} : (memref<10x2xindex>) -> memref<1xindex>
    %6 = "memref.subview"(%5) {operand_segment_sizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>} : (memref<10x2xindex>) -> memref<1x1xindex>
    "memref.dealloc"(%2) : (memref<1xindex>) -> ()
    "memref.dealloc"(%5) : (memref<10x2xindex>) -> ()
    "func.return"() : () -> ()
  }) {"sym_name" = "memref_test", "function_type" = () -> (), "sym_visibility" = "private"} : () -> ()
}) : () -> ()

