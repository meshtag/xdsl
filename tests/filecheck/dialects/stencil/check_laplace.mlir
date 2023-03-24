#map0 = affine_map<(d0, d1, d2) -> (d0 * 5184 + d1 * 72 + d2 + 20955)>
#map1 = affine_map<(d0, d1, d2) -> (d0 * 5184 + d1 * 72 + d2 + 21028)>

"builtin.module"() ({
  func.func private @printMemrefF64(memref<*xf64>)

  func.func @laplace_oec(%arg0: memref<?x?x?xf64>, %arg1: memref<?x?x?xf64>) {
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant -4.000000e+00 : f64
    %0 = memref.cast %arg0 : memref<?x?x?xf64> to memref<72x72x72xf64>
    %1 = memref.cast %arg1 : memref<?x?x?xf64> to memref<72x72x72xf64>
    %2 = memref.subview %0[4, 3, 3] [64, 66, 66] [1, 1, 1] : memref<72x72x72xf64> to memref<64x66x66xf64, #map0>
    %3 = memref.subview %1[4, 4, 4] [64, 64, 64] [1, 1, 1] : memref<72x72x72xf64> to memref<64x64x64xf64, #map1>
    scf.parallel (%arg2, %arg3, %arg4) = (%c0, %c0, %c0) to (%c64, %c64, %c64) step (%c1, %c1, %c1) {
      %4 = arith.addi %arg3, %c1 : index
      %5 = memref.load %2[%arg4, %4, %arg2] : memref<64x66x66xf64, #map0>
      %6 = arith.addi %arg2, %c2 : index
      %7 = arith.addi %arg3, %c1 : index
      %8 = memref.load %2[%arg4, %7, %6] : memref<64x66x66xf64, #map0>
      %9 = arith.addi %arg2, %c1 : index
      %10 = arith.addi %arg3, %c2 : index
      %11 = memref.load %2[%arg4, %10, %9] : memref<64x66x66xf64, #map0>
      %12 = arith.addi %arg2, %c1 : index
      %13 = memref.load %2[%arg4, %arg3, %12] : memref<64x66x66xf64, #map0>
      %14 = arith.addi %arg2, %c1 : index
      %15 = arith.addi %arg3, %c1 : index
      %16 = memref.load %2[%arg4, %15, %14] : memref<64x66x66xf64, #map0>
      %17 = arith.addf %5, %8 : f64
      %18 = arith.addf %11, %13 : f64
      %19 = arith.addf %17, %18 : f64
      %20 = arith.mulf %16, %cst : f64
      %21 = arith.addf %20, %19 : f64
      memref.store %21, %3[%arg4, %arg3, %arg2] : memref<64x64x64xf64, #map1>
      scf.yield
    }
    return
  }

  func.func @laplace_xdsl(%arg0: memref<?x?x?xf64>, %arg1: memref<?x?x?xf64>) attributes {stencil.program} {
    %cst = arith.constant -4.000000e+00 : f64
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c64 = arith.constant 64 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    scf.parallel (%arg2, %arg3, %arg4) = (%c0, %c0, %c0) to (%c64, %c64, %c64) step (%c1, %c1, %c1) {
      %0 = arith.addi %arg2, %c3 : index
      %1 = arith.addi %arg3, %c4 : index
      %2 = arith.addi %arg4, %c4 : index
      %3 = memref.load %arg0[%0, %1, %2] : memref<?x?x?xf64>
      %4 = arith.addi %arg2, %c5 : index
      %5 = arith.addi %arg3, %c4 : index
      %6 = arith.addi %arg4, %c4 : index
      %7 = memref.load %arg0[%4, %5, %6] : memref<?x?x?xf64>
      %8 = arith.addi %arg2, %c4 : index
      %9 = arith.addi %arg3, %c5 : index
      %10 = arith.addi %arg4, %c4 : index
      %11 = memref.load %arg0[%8, %9, %10] : memref<?x?x?xf64>
      %12 = arith.addi %arg2, %c4 : index
      %13 = arith.addi %arg3, %c3 : index
      %14 = arith.addi %arg4, %c4 : index
      %15 = memref.load %arg0[%12, %13, %14] : memref<?x?x?xf64>
      %16 = arith.addi %arg2, %c4 : index
      %17 = arith.addi %arg3, %c4 : index
      %18 = arith.addi %arg4, %c4 : index
      %19 = memref.load %arg0[%16, %17, %18] : memref<?x?x?xf64>
      %20 = arith.addf %3, %7 : f64
      %21 = arith.addf %11, %15 : f64
      %22 = arith.addf %20, %21 : f64
      %23 = arith.mulf %19, %cst : f64
      %24 = arith.addf %23, %22 : f64
      %25 = arith.addi %arg2, %c4 : index
      %26 = arith.addi %arg3, %c4 : index
      %27 = arith.addi %arg4, %c4 : index
      memref.store %24, %arg1[%25, %26, %27] : memref<?x?x?xf64>
      scf.yield
    }
    return
  }

  func.func @alloc_3d_filled_f64(%arg0: index, %arg1: index, %arg2: index, %arg3: f64) -> memref<?x?x?xf64> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = memref.alloc(%arg0, %arg1, %arg2) : memref<?x?x?xf64>
    scf.for %arg4 = %c0 to %arg0 step %c1 {
      scf.for %arg5 = %c0 to %arg1 step %c1 {
        scf.for %arg6 = %c0 to %arg2 step %c1 {
          memref.store %arg3, %0[%arg4, %arg5, %arg6] : memref<?x?x?xf64>
        }
      }
    }
    return %0 : memref<?x?x?xf64>
  }

  func.func @compare_3d_memref_f64(%dim1: index, %dim2: index, %dim3: index, %memref1 : memref<?x?x?xf64>, %memref2 : memref<?x?x?xf64>) -> i1 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %false_val = arith.constant 1 : i1

    scf.for %i = %c0 to %dim1 step %c1 {
      scf.for %j = %c0 to %dim2 step %c1 {
        scf.for %k = %c0 to %dim3 step %c1 {
          %val1 = memref.load %memref1[%i, %j, %k] : memref<?x?x?xf64>
          %val2 = memref.load %memref2[%i, %j, %k] : memref<?x?x?xf64>

          %check_val = arith.cmpf one, %val1, %val2 : f64
          scf.if %check_val {
            %c404 = arith.constant 404 : index
            vector.print %c404 : index
          } 
        }
      }
    }

    %true_val = arith.constant 1 : i1
    return %true_val : i1
  }

  "func.func"() ({
    %c44 = "arith.constant"() {"value" = 44 : index} : () -> index

    %memref1_size1 = "arith.constant"() {"value" = 100 : index} : () -> index
    %memref1_size2 = "arith.constant"() {"value" = 100 : index} : () -> index
    %memref1_size3 = "arith.constant"() {"value" = 100 : index} : () -> index
    %memref1_elem = "arith.constant"() {"value" = 7.0 : f64} : () -> f64
    %memref1 = func.call @alloc_3d_filled_f64(%memref1_size1, %memref1_size2, %memref1_size3, %memref1_elem) : (index, index, index, f64) -> memref<?x?x?xf64>

    %memref2_elem = "arith.constant"() {"value" = 9.0 : f64} : () -> f64
    %memref2_xdsl = func.call @alloc_3d_filled_f64(%memref1_size1, %memref1_size2, %memref1_size3, %memref2_elem) : (index, index, index, f64) -> memref<?x?x?xf64>
    %memref2_oec = func.call @alloc_3d_filled_f64(%memref1_size1, %memref1_size2, %memref1_size3, %memref2_elem) : (index, index, index, f64) -> memref<?x?x?xf64>

    func.call @laplace_xdsl(%memref1, %memref2_xdsl) : (memref<?x?x?xf64>, memref<?x?x?xf64>) -> ()
    func.call @laplace_oec(%memref1, %memref2_oec) : (memref<?x?x?xf64>, memref<?x?x?xf64>) -> ()

    // %print_memref1 = memref.cast %memref1 : memref<?x?x?xf64> to memref<*xf64>
    // func.call @printMemrefF64(%print_memref1) : (memref<*xf64>) -> ()

    // %print_memref2_xdsl = memref.cast %memref2_xdsl : memref<?x?x?xf64> to memref<*xf64>
    // func.call @printMemrefF64(%print_memref2_xdsl) : (memref<*xf64>) -> ()

    // %print_memref2_oec = memref.cast %memref2_oec : memref<?x?x?xf64> to memref<*xf64>
    // func.call @printMemrefF64(%print_memref2_oec) : (memref<*xf64>) -> ()

    %check_eq_memrefs = func.call @compare_3d_memref_f64(%memref1_size1, %memref1_size2, %memref1_size3, %memref2_xdsl, %memref2_oec) : (index, index, index, memref<?x?x?xf64>, memref<?x?x?xf64>) -> i1
    vector.print %check_eq_memrefs : i1

    vector.print %c44 : index

    "func.return"() : () -> ()
  }) {"sym_name" = "main", "function_type" = () -> (), "sym_visibility" = "private"} : () -> ()

}) : () -> ()
