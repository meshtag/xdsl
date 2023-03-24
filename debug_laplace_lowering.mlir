module attributes {llvm.data_layout = ""} {
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @printI64(i64)
  llvm.func @printF64(f64)
  llvm.func @printNewline()
  llvm.func @printU64(i64)
  llvm.func @printMemrefF64(i64, !llvm.ptr<i8>) attributes {sym_visibility = "private"}
  llvm.func @laplace_oec(%arg0: !llvm.ptr<f64>, %arg1: !llvm.ptr<f64>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: !llvm.ptr<f64>, %arg10: !llvm.ptr<f64>, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i64, %arg16: i64, %arg17: i64) {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %arg6, %4[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %7 = llvm.insertvalue %arg7, %6[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %8 = llvm.insertvalue %arg5, %7[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %9 = llvm.insertvalue %arg8, %8[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %10 = builtin.unrealized_conversion_cast %9 : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> to memref<?x?x?xf64>
    %11 = builtin.unrealized_conversion_cast %10 : memref<?x?x?xf64> to !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.mlir.constant(64 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.extractvalue %11[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %16 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64)>
    %18 = llvm.insertvalue %15, %17[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64)> 
    %19 = llvm.insertvalue %16, %18[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64)> 
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64)> 
    %22 = llvm.extractvalue %11[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %23 = llvm.extractvalue %11[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %24 = llvm.extractvalue %11[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %25 = llvm.extractvalue %11[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %26 = llvm.extractvalue %11[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %27 = llvm.extractvalue %11[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %28 = llvm.extractvalue %11[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %29 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %30 = llvm.extractvalue %21[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64)> 
    %31 = llvm.extractvalue %21[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64)> 
    %32 = llvm.insertvalue %30, %29[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %33 = llvm.insertvalue %31, %32[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %34 = llvm.mlir.constant(20955 : index) : i64
    %35 = llvm.insertvalue %34, %33[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %36 = llvm.mlir.constant(64 : index) : i64
    %37 = llvm.insertvalue %36, %35[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %38 = llvm.mlir.constant(5184 : index) : i64
    %39 = llvm.insertvalue %38, %37[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %40 = llvm.mlir.constant(66 : index) : i64
    %41 = llvm.insertvalue %40, %39[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %42 = llvm.mlir.constant(72 : index) : i64
    %43 = llvm.insertvalue %42, %41[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %44 = llvm.mlir.constant(66 : index) : i64
    %45 = llvm.insertvalue %44, %43[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %46 = llvm.mlir.constant(1 : index) : i64
    %47 = llvm.insertvalue %46, %45[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    llvm.br ^bb1(%12 : i64)
  ^bb1(%48: i64):  // 2 preds: ^bb0, ^bb8
    %49 = builtin.unrealized_conversion_cast %48 : i64 to index
    %50 = builtin.unrealized_conversion_cast %49 : index to i64
    %51 = llvm.icmp "slt" %48, %13 : i64
    llvm.cond_br %51, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%12 : i64)
  ^bb3(%52: i64):  // 2 preds: ^bb2, ^bb7
    %53 = llvm.icmp "slt" %52, %13 : i64
    llvm.cond_br %53, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%12 : i64)
  ^bb5(%54: i64):  // 2 preds: ^bb4, ^bb6
    %55 = builtin.unrealized_conversion_cast %54 : i64 to index
    %56 = builtin.unrealized_conversion_cast %55 : index to i64
    %57 = llvm.icmp "slt" %54, %13 : i64
    llvm.cond_br %57, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %58 = llvm.add %52, %14  : i64
    %59 = builtin.unrealized_conversion_cast %58 : i64 to index
    %60 = builtin.unrealized_conversion_cast %59 : index to i64
    %61 = builtin.unrealized_conversion_cast %59 : index to i64
    llvm.call @printU64(%61) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    %62 = llvm.extractvalue %47[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %63 = llvm.mlir.constant(20955 : index) : i64
    %64 = llvm.mlir.constant(5184 : index) : i64
    %65 = llvm.mul %56, %64  : i64
    %66 = llvm.add %63, %65  : i64
    %67 = llvm.mlir.constant(72 : index) : i64
    %68 = llvm.mul %60, %67  : i64
    %69 = llvm.add %66, %68  : i64
    %70 = llvm.add %69, %50  : i64
    %71 = llvm.getelementptr %62[%70] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %72 = llvm.load %71 : !llvm.ptr<f64>
    llvm.call @printF64(%72) : (f64) -> ()
    llvm.call @printNewline() : () -> ()
    %73 = llvm.add %54, %14  : i64
    llvm.br ^bb5(%73 : i64)
  ^bb7:  // pred: ^bb5
    %74 = llvm.add %52, %14  : i64
    llvm.br ^bb3(%74 : i64)
  ^bb8:  // pred: ^bb3
    %75 = llvm.add %48, %14  : i64
    llvm.br ^bb1(%75 : i64)
  ^bb9:  // pred: ^bb1
    llvm.return
  }
  llvm.func @laplace_xdsl(%arg0: !llvm.ptr<f64>, %arg1: !llvm.ptr<f64>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: !llvm.ptr<f64>, %arg10: !llvm.ptr<f64>, %arg11: i64, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i64, %arg16: i64, %arg17: i64) attributes {stencil.program} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %arg6, %4[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %7 = llvm.insertvalue %arg7, %6[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %8 = llvm.insertvalue %arg5, %7[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %9 = llvm.insertvalue %arg8, %8[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %10 = builtin.unrealized_conversion_cast %9 : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> to memref<?x?x?xf64>
    %11 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %12 = llvm.insertvalue %arg9, %11[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %13 = llvm.insertvalue %arg10, %12[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %14 = llvm.insertvalue %arg11, %13[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %15 = llvm.insertvalue %arg12, %14[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %16 = llvm.insertvalue %arg15, %15[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.insertvalue %arg13, %16[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = llvm.insertvalue %arg16, %17[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.insertvalue %arg14, %18[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %20 = llvm.insertvalue %arg17, %19[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %21 = builtin.unrealized_conversion_cast %20 : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> to memref<?x?x?xf64>
    %22 = builtin.unrealized_conversion_cast %10 : memref<?x?x?xf64> to !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %23 = builtin.unrealized_conversion_cast %21 : memref<?x?x?xf64> to !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %24 = llvm.mlir.constant(-4.000000e+00 : f64) : f64
    %25 = llvm.mlir.constant(5 : index) : i64
    %26 = llvm.mlir.constant(4 : index) : i64
    %27 = llvm.mlir.constant(3 : index) : i64
    %28 = llvm.mlir.constant(64 : index) : i64
    %29 = llvm.mlir.constant(1 : index) : i64
    %30 = llvm.mlir.constant(0 : index) : i64
    llvm.br ^bb1(%30 : i64)
  ^bb1(%31: i64):  // 2 preds: ^bb0, ^bb8
    %32 = llvm.icmp "slt" %31, %28 : i64
    llvm.cond_br %32, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%30 : i64)
  ^bb3(%33: i64):  // 2 preds: ^bb2, ^bb7
    %34 = llvm.icmp "slt" %33, %28 : i64
    llvm.cond_br %34, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%30 : i64)
  ^bb5(%35: i64):  // 2 preds: ^bb4, ^bb6
    %36 = llvm.icmp "slt" %35, %28 : i64
    llvm.cond_br %36, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %37 = llvm.add %31, %27  : i64
    %38 = builtin.unrealized_conversion_cast %37 : i64 to index
    %39 = builtin.unrealized_conversion_cast %38 : index to i64
    %40 = llvm.add %33, %26  : i64
    %41 = builtin.unrealized_conversion_cast %40 : i64 to index
    %42 = builtin.unrealized_conversion_cast %41 : index to i64
    %43 = llvm.add %35, %26  : i64
    %44 = builtin.unrealized_conversion_cast %43 : i64 to index
    %45 = builtin.unrealized_conversion_cast %44 : index to i64
    %46 = llvm.extractvalue %22[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %47 = llvm.extractvalue %22[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %48 = llvm.mul %39, %47  : i64
    %49 = llvm.extractvalue %22[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %50 = llvm.mul %42, %49  : i64
    %51 = llvm.add %48, %50  : i64
    %52 = llvm.add %51, %45  : i64
    %53 = llvm.getelementptr %46[%52] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %54 = llvm.load %53 : !llvm.ptr<f64>
    %55 = llvm.add %31, %25  : i64
    %56 = builtin.unrealized_conversion_cast %55 : i64 to index
    %57 = builtin.unrealized_conversion_cast %56 : index to i64
    %58 = llvm.add %33, %26  : i64
    %59 = builtin.unrealized_conversion_cast %58 : i64 to index
    %60 = builtin.unrealized_conversion_cast %59 : index to i64
    %61 = llvm.add %35, %26  : i64
    %62 = builtin.unrealized_conversion_cast %61 : i64 to index
    %63 = builtin.unrealized_conversion_cast %62 : index to i64
    %64 = llvm.extractvalue %22[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %65 = llvm.extractvalue %22[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %66 = llvm.mul %57, %65  : i64
    %67 = llvm.extractvalue %22[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %68 = llvm.mul %60, %67  : i64
    %69 = llvm.add %66, %68  : i64
    %70 = llvm.add %69, %63  : i64
    %71 = llvm.getelementptr %64[%70] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %72 = llvm.load %71 : !llvm.ptr<f64>
    %73 = llvm.add %31, %26  : i64
    %74 = builtin.unrealized_conversion_cast %73 : i64 to index
    %75 = builtin.unrealized_conversion_cast %74 : index to i64
    %76 = llvm.add %33, %25  : i64
    %77 = builtin.unrealized_conversion_cast %76 : i64 to index
    %78 = builtin.unrealized_conversion_cast %77 : index to i64
    %79 = llvm.add %35, %26  : i64
    %80 = builtin.unrealized_conversion_cast %79 : i64 to index
    %81 = builtin.unrealized_conversion_cast %80 : index to i64
    %82 = llvm.extractvalue %22[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %83 = llvm.extractvalue %22[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %84 = llvm.mul %75, %83  : i64
    %85 = llvm.extractvalue %22[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %86 = llvm.mul %78, %85  : i64
    %87 = llvm.add %84, %86  : i64
    %88 = llvm.add %87, %81  : i64
    %89 = llvm.getelementptr %82[%88] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %90 = llvm.load %89 : !llvm.ptr<f64>
    %91 = llvm.add %31, %26  : i64
    %92 = builtin.unrealized_conversion_cast %91 : i64 to index
    %93 = builtin.unrealized_conversion_cast %92 : index to i64
    %94 = llvm.add %33, %27  : i64
    %95 = builtin.unrealized_conversion_cast %94 : i64 to index
    %96 = builtin.unrealized_conversion_cast %95 : index to i64
    %97 = llvm.add %35, %26  : i64
    %98 = builtin.unrealized_conversion_cast %97 : i64 to index
    %99 = builtin.unrealized_conversion_cast %98 : index to i64
    %100 = llvm.extractvalue %22[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %101 = llvm.extractvalue %22[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %102 = llvm.mul %93, %101  : i64
    %103 = llvm.extractvalue %22[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %104 = llvm.mul %96, %103  : i64
    %105 = llvm.add %102, %104  : i64
    %106 = llvm.add %105, %99  : i64
    %107 = llvm.getelementptr %100[%106] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %108 = llvm.load %107 : !llvm.ptr<f64>
    %109 = llvm.add %31, %26  : i64
    %110 = builtin.unrealized_conversion_cast %109 : i64 to index
    %111 = builtin.unrealized_conversion_cast %110 : index to i64
    %112 = llvm.add %33, %26  : i64
    %113 = builtin.unrealized_conversion_cast %112 : i64 to index
    %114 = builtin.unrealized_conversion_cast %113 : index to i64
    %115 = llvm.add %35, %26  : i64
    %116 = builtin.unrealized_conversion_cast %115 : i64 to index
    %117 = builtin.unrealized_conversion_cast %116 : index to i64
    %118 = llvm.extractvalue %22[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %119 = llvm.extractvalue %22[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %120 = llvm.mul %111, %119  : i64
    %121 = llvm.extractvalue %22[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %122 = llvm.mul %114, %121  : i64
    %123 = llvm.add %120, %122  : i64
    %124 = llvm.add %123, %117  : i64
    %125 = llvm.getelementptr %118[%124] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %126 = llvm.load %125 : !llvm.ptr<f64>
    %127 = llvm.fadd %54, %72  : f64
    %128 = llvm.fadd %90, %108  : f64
    %129 = llvm.fadd %127, %128  : f64
    %130 = llvm.fmul %126, %24  : f64
    %131 = llvm.fadd %130, %129  : f64
    %132 = llvm.add %31, %26  : i64
    %133 = builtin.unrealized_conversion_cast %132 : i64 to index
    %134 = builtin.unrealized_conversion_cast %133 : index to i64
    %135 = llvm.add %33, %26  : i64
    %136 = builtin.unrealized_conversion_cast %135 : i64 to index
    %137 = builtin.unrealized_conversion_cast %136 : index to i64
    %138 = llvm.add %35, %26  : i64
    %139 = builtin.unrealized_conversion_cast %138 : i64 to index
    %140 = builtin.unrealized_conversion_cast %139 : index to i64
    %141 = llvm.extractvalue %23[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %142 = llvm.extractvalue %23[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %143 = llvm.mul %134, %142  : i64
    %144 = llvm.extractvalue %23[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %145 = llvm.mul %137, %144  : i64
    %146 = llvm.add %143, %145  : i64
    %147 = llvm.add %146, %140  : i64
    %148 = llvm.getelementptr %141[%147] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    llvm.store %131, %148 : !llvm.ptr<f64>
    %149 = llvm.add %35, %29  : i64
    llvm.br ^bb5(%149 : i64)
  ^bb7:  // pred: ^bb5
    %150 = llvm.add %33, %29  : i64
    llvm.br ^bb3(%150 : i64)
  ^bb8:  // pred: ^bb3
    %151 = llvm.add %31, %29  : i64
    llvm.br ^bb1(%151 : i64)
  ^bb9:  // pred: ^bb1
    llvm.return
  }
  llvm.func @alloc_3d_filled_f64(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: f64) -> !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> {
    %0 = builtin.unrealized_conversion_cast %arg2 : i64 to index
    %1 = builtin.unrealized_conversion_cast %arg1 : i64 to index
    %2 = builtin.unrealized_conversion_cast %arg0 : i64 to index
    %3 = builtin.unrealized_conversion_cast %2 : index to i64
    %4 = builtin.unrealized_conversion_cast %1 : index to i64
    %5 = builtin.unrealized_conversion_cast %0 : index to i64
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.constant(1 : index) : i64
    %9 = llvm.mul %5, %4  : i64
    %10 = llvm.mul %9, %3  : i64
    %11 = llvm.mlir.null : !llvm.ptr<f64>
    %12 = llvm.getelementptr %11[%10] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %13 = llvm.ptrtoint %12 : !llvm.ptr<f64> to i64
    %14 = llvm.call @malloc(%13) : (i64) -> !llvm.ptr<i8>
    %15 = llvm.bitcast %14 : !llvm.ptr<i8> to !llvm.ptr<f64>
    %16 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %17 = llvm.insertvalue %15, %16[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = llvm.insertvalue %15, %17[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.mlir.constant(0 : index) : i64
    %20 = llvm.insertvalue %19, %18[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %21 = llvm.insertvalue %3, %20[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %22 = llvm.insertvalue %4, %21[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %23 = llvm.insertvalue %5, %22[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %24 = llvm.insertvalue %9, %23[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %25 = llvm.insertvalue %5, %24[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %26 = llvm.insertvalue %8, %25[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %27 = builtin.unrealized_conversion_cast %26 : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> to memref<?x?x?xf64>
    llvm.br ^bb1(%6 : i64)
  ^bb1(%28: i64):  // 2 preds: ^bb0, ^bb8
    %29 = builtin.unrealized_conversion_cast %28 : i64 to index
    %30 = builtin.unrealized_conversion_cast %29 : index to i64
    %31 = llvm.icmp "slt" %28, %arg0 : i64
    llvm.cond_br %31, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%6 : i64)
  ^bb3(%32: i64):  // 2 preds: ^bb2, ^bb7
    %33 = builtin.unrealized_conversion_cast %32 : i64 to index
    %34 = builtin.unrealized_conversion_cast %33 : index to i64
    %35 = llvm.icmp "slt" %32, %arg1 : i64
    llvm.cond_br %35, ^bb4, ^bb8
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%6 : i64)
  ^bb5(%36: i64):  // 2 preds: ^bb4, ^bb6
    %37 = builtin.unrealized_conversion_cast %36 : i64 to index
    %38 = builtin.unrealized_conversion_cast %37 : index to i64
    %39 = llvm.icmp "slt" %36, %arg2 : i64
    llvm.cond_br %39, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %40 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %41 = llvm.extractvalue %26[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %42 = llvm.mul %30, %41  : i64
    %43 = llvm.extractvalue %26[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %44 = llvm.mul %34, %43  : i64
    %45 = llvm.add %42, %44  : i64
    %46 = llvm.add %45, %38  : i64
    %47 = llvm.getelementptr %40[%46] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    llvm.store %arg3, %47 : !llvm.ptr<f64>
    %48 = llvm.add %36, %7  : i64
    llvm.br ^bb5(%48 : i64)
  ^bb7:  // pred: ^bb5
    %49 = llvm.add %32, %7  : i64
    llvm.br ^bb3(%49 : i64)
  ^bb8:  // pred: ^bb3
    %50 = llvm.add %28, %7  : i64
    llvm.br ^bb1(%50 : i64)
  ^bb9:  // pred: ^bb1
    llvm.return %26 : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
  }
  llvm.func @compare_3d_memref_f64(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: !llvm.ptr<f64>, %arg4: !llvm.ptr<f64>, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: !llvm.ptr<f64>, %arg13: !llvm.ptr<f64>, %arg14: i64, %arg15: i64, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: i64) -> i1 {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %1 = llvm.insertvalue %arg3, %0[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %2 = llvm.insertvalue %arg4, %1[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %3 = llvm.insertvalue %arg5, %2[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %4 = llvm.insertvalue %arg6, %3[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %5 = llvm.insertvalue %arg9, %4[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %6 = llvm.insertvalue %arg7, %5[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %7 = llvm.insertvalue %arg10, %6[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %8 = llvm.insertvalue %arg8, %7[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %9 = llvm.insertvalue %arg11, %8[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %10 = builtin.unrealized_conversion_cast %9 : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> to memref<?x?x?xf64>
    %11 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %12 = llvm.insertvalue %arg12, %11[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %13 = llvm.insertvalue %arg13, %12[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %14 = llvm.insertvalue %arg14, %13[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %15 = llvm.insertvalue %arg15, %14[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %16 = llvm.insertvalue %arg18, %15[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.insertvalue %arg16, %16[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = llvm.insertvalue %arg19, %17[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.insertvalue %arg17, %18[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %20 = llvm.insertvalue %arg20, %19[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %21 = builtin.unrealized_conversion_cast %20 : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> to memref<?x?x?xf64>
    %22 = builtin.unrealized_conversion_cast %10 : memref<?x?x?xf64> to !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %23 = builtin.unrealized_conversion_cast %21 : memref<?x?x?xf64> to !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %24 = llvm.mlir.constant(404 : index) : i64
    %25 = builtin.unrealized_conversion_cast %24 : i64 to index
    %26 = builtin.unrealized_conversion_cast %25 : index to i64
    %27 = llvm.mlir.constant(0 : index) : i64
    %28 = llvm.mlir.constant(1 : index) : i64
    %29 = llvm.mlir.constant(true) : i1
    llvm.br ^bb1(%27 : i64)
  ^bb1(%30: i64):  // 2 preds: ^bb0, ^bb10
    %31 = builtin.unrealized_conversion_cast %30 : i64 to index
    %32 = builtin.unrealized_conversion_cast %31 : index to i64
    %33 = llvm.icmp "slt" %30, %arg0 : i64
    llvm.cond_br %33, ^bb2, ^bb11
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%27 : i64)
  ^bb3(%34: i64):  // 2 preds: ^bb2, ^bb9
    %35 = builtin.unrealized_conversion_cast %34 : i64 to index
    %36 = builtin.unrealized_conversion_cast %35 : index to i64
    %37 = llvm.icmp "slt" %34, %arg1 : i64
    llvm.cond_br %37, ^bb4, ^bb10
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5(%27 : i64)
  ^bb5(%38: i64):  // 2 preds: ^bb4, ^bb8
    %39 = builtin.unrealized_conversion_cast %38 : i64 to index
    %40 = builtin.unrealized_conversion_cast %39 : index to i64
    %41 = llvm.icmp "slt" %38, %arg2 : i64
    llvm.cond_br %41, ^bb6, ^bb9
  ^bb6:  // pred: ^bb5
    %42 = llvm.extractvalue %22[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %43 = llvm.extractvalue %22[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %44 = llvm.mul %32, %43  : i64
    %45 = llvm.extractvalue %22[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %46 = llvm.mul %36, %45  : i64
    %47 = llvm.add %44, %46  : i64
    %48 = llvm.add %47, %40  : i64
    %49 = llvm.getelementptr %42[%48] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %50 = llvm.load %49 : !llvm.ptr<f64>
    %51 = llvm.extractvalue %23[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %52 = llvm.extractvalue %23[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %53 = llvm.mul %32, %52  : i64
    %54 = llvm.extractvalue %23[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %55 = llvm.mul %36, %54  : i64
    %56 = llvm.add %53, %55  : i64
    %57 = llvm.add %56, %40  : i64
    %58 = llvm.getelementptr %51[%57] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %59 = llvm.load %58 : !llvm.ptr<f64>
    %60 = llvm.fcmp "one" %50, %59 : f64
    llvm.cond_br %60, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    llvm.call @printU64(%26) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.br ^bb8
  ^bb8:  // 2 preds: ^bb6, ^bb7
    %61 = llvm.add %38, %28  : i64
    llvm.br ^bb5(%61 : i64)
  ^bb9:  // pred: ^bb5
    %62 = llvm.add %34, %28  : i64
    llvm.br ^bb3(%62 : i64)
  ^bb10:  // pred: ^bb3
    %63 = llvm.add %30, %28  : i64
    llvm.br ^bb1(%63 : i64)
  ^bb11:  // pred: ^bb1
    llvm.return %29 : i1
  }
  llvm.func @main() attributes {sym_visibility = "private"} {
    %0 = llvm.mlir.constant(9.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(44 : index) : i64
    %2 = builtin.unrealized_conversion_cast %1 : i64 to index
    %3 = builtin.unrealized_conversion_cast %2 : index to i64
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %6 = llvm.call @alloc_3d_filled_f64(%4, %4, %4, %5) : (i64, i64, i64, f64) -> !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %7 = llvm.call @alloc_3d_filled_f64(%4, %4, %4, %0) : (i64, i64, i64, f64) -> !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %8 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %9 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %10 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %11 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %12 = llvm.extractvalue %6[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %13 = llvm.extractvalue %6[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %14 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %15 = llvm.extractvalue %6[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %16 = llvm.extractvalue %6[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.extractvalue %7[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = llvm.extractvalue %7[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.extractvalue %7[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %20 = llvm.extractvalue %7[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %21 = llvm.extractvalue %7[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %22 = llvm.extractvalue %7[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %23 = llvm.extractvalue %7[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %24 = llvm.extractvalue %7[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %25 = llvm.extractvalue %7[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    llvm.call @laplace_xdsl(%8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22, %23, %24, %25) : (!llvm.ptr<f64>, !llvm.ptr<f64>, i64, i64, i64, i64, i64, i64, i64, !llvm.ptr<f64>, !llvm.ptr<f64>, i64, i64, i64, i64, i64, i64, i64) -> ()
    %26 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %27 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %28 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %29 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %30 = llvm.extractvalue %6[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %31 = llvm.extractvalue %6[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %32 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %33 = llvm.extractvalue %6[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %34 = llvm.extractvalue %6[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %35 = llvm.extractvalue %6[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %36 = llvm.extractvalue %6[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %37 = llvm.extractvalue %6[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %38 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %39 = llvm.extractvalue %6[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %40 = llvm.extractvalue %6[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %41 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %42 = llvm.extractvalue %6[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %43 = llvm.extractvalue %6[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %44 = llvm.call @compare_3d_memref_f64(%4, %4, %4, %26, %27, %28, %29, %30, %31, %32, %33, %34, %35, %36, %37, %38, %39, %40, %41, %42, %43) : (i64, i64, i64, !llvm.ptr<f64>, !llvm.ptr<f64>, i64, i64, i64, i64, i64, i64, i64, !llvm.ptr<f64>, !llvm.ptr<f64>, i64, i64, i64, i64, i64, i64, i64) -> i1
    %45 = llvm.zext %44 : i1 to i64
    llvm.call @printI64(%45) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.call @printU64(%3) : (i64) -> ()
    llvm.call @printNewline() : () -> ()
    llvm.return
  }
}

