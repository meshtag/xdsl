"builtin.module"() ({
  "func.func"() ({
    %0 = "arith.constant"() {"value" = 0 : index} : () -> index
    %1 = "memref.alloca"() {"alignment" = 0 : i64, "operand_segment_sizes" = dense<[0, 0]> : vector<2xi32>} : () -> memref<4xindex>
    %2 = "vector.load"(%1, %0) : (memref<4xindex>, index) -> vector<2xindex>
    "vector.store"(%2, %1, %0) : (vector<2xindex>, memref<4xindex>, index) -> ()
    %3 = "vector.fma"(%2, %2, %2) : (vector<2xindex>, vector<2xindex>, vector<2xindex>) -> vector<2xindex>
    %4 = "arith.constant"() {"value" = true} : () -> i1
    %5 = "vector.broadcast"(%4) : (i1) -> vector<2xi1>
    %6 = "vector.maskedload"(%1, %0, %5, %2) : (memref<4xindex>, index, vector<2xi1>, vector<2xindex>) -> vector<2xindex>
    "vector.maskedstore"(%1, %0, %5, %2) : (memref<4xindex>, index, vector<2xi1>, vector<2xindex>) -> ()
    "vector.print"(%2) : (vector<2xindex>) -> ()
    "memref.dealloc"(%1) : (memref<4xindex>) -> ()
    "func.return"() : () -> ()
  }) {"sym_name" = "vector_test", "function_type" = () -> (), "sym_visibility" = "private"} : () -> ()
}) : () -> ()
