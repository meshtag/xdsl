"builtin.module"() ({
  "func.func"() ({
    %0 = "arith.constant"() {"value" = 0 : index} : () -> index
    %1 = "memref.alloca"() {"alignment" = 0 : i64, "operand_segment_sizes" = dense<[0, 0]> : vector<2xi32>} : () -> memref<1xindex>
    %2 = "vector.load"(%1, %0) : (memref<1xindex>, index) -> index
    "func.return"() : () -> ()
  }) {"sym_name" = "vector_test", "function_type" = () -> (), "sym_visibility" = "private"} : () -> ()
}) : () -> ()
