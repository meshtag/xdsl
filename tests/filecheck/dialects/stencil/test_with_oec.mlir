

#map0 = affine_map<(d0, d1, d2) -> (d0 * 5184 + d1 * 72 + d2 + 20955)>
#map1 = affine_map<(d0, d1, d2) -> (d0 * 5184 + d1 * 72 + d2 + 21028)>
#map2 = affine_map<(d0) -> (d0)>
#map3 = affine_map<(d0, d1) -> (d0 + d1)>
module  {
  func @laplace_oec(%arg0: memref<?x?x?xf64>, %arg1: memref<?x?x?xf64>) {
    %0 = memref_cast %arg0 : memref<?x?x?xf64> to memref<72x72x72xf64>
    %1 = memref_cast %arg1 : memref<?x?x?xf64> to memref<72x72x72xf64>
    %2 = subview %0[4, 3, 3] [64, 66, 66] [1, 1, 1] : memref<72x72x72xf64> to memref<64x66x66xf64, #map0>
    %3 = subview %1[4, 4, 4] [64, 64, 64] [1, 1, 1] : memref<72x72x72xf64> to memref<64x64x64xf64, #map1>
    %c0 = constant 0 : index
    %c64 = constant 64 : index
    %c1 = constant 1 : index
    scf.parallel (%arg2, %arg3, %arg4) = (%c0, %c0, %c0) to (%c64, %c64, %c64) step (%c1, %c1, %c1) {
      %4 = affine.apply #map2(%arg2)
      %5 = affine.apply #map2(%arg3)
      %6 = affine.apply #map2(%arg4)
      %7 = affine.apply #map3(%4, %c0)
      %8 = affine.apply #map3(%5, %c1)
      %9 = affine.apply #map3(%6, %c0)
      %10 = load %2[%9, %8, %7] : memref<64x66x66xf64, #map0>
      %c2 = constant 2 : index
      %11 = affine.apply #map3(%4, %c2)
      %12 = load %2[%9, %8, %11] : memref<64x66x66xf64, #map0>
      %13 = affine.apply #map3(%4, %c1)
      %14 = affine.apply #map3(%5, %c2)
      %15 = load %2[%9, %14, %13] : memref<64x66x66xf64, #map0>
      %16 = affine.apply #map3(%5, %c0)
      %17 = load %2[%9, %16, %13] : memref<64x66x66xf64, #map0>
      %18 = load %2[%9, %8, %13] : memref<64x66x66xf64, #map0>
      %19 = addf %10, %12 : f64
      %20 = addf %15, %17 : f64
      %21 = addf %19, %20 : f64
      %cst = constant -4.000000e+00 : f64
      %22 = mulf %18, %cst : f64
      %23 = addf %22, %21 : f64
      store %23, %3[%9, %16, %7] : memref<64x64x64xf64, #map1>
      scf.yield
    }
    return
  }
}

