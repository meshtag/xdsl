"builtin.module"() ({
  "func.func"() ({
    %0 = "arith.constant"() {"value" = 0 : index} : () -> index
    %1 = "memref.alloca"() {"alignment" = 0 : i64, "operand_segment_sizes" = dense<[0, 0]> : vector<2xi32>} : () -> memref<1xindex>
    %2 = "vector.load"(%1, %0) : (memref<1xindex>, index) -> vector<1xindex>
    "vector.store"(%2, %1, %0) : (vector<1xindex>, memref<1xindex>, index) -> ()
    %3 = "vector.fma"(%2, %2, %2) : (vector<1xindex>, vector<1xindex>, vector<1xindex>) -> vector<1xindex>
    "memref.dealloc"(%1) : (memref<1xindex>) -> ()
    "func.return"() : () -> ()
  }) {"sym_name" = "vector_test", "function_type" = () -> (), "sym_visibility" = "private"} : () -> ()
}) : () -> ()
