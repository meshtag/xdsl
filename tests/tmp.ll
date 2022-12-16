; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@g = global [1 x i64] zeroinitializer

declare i8* @malloc(i64)

declare void @free(i8*)

define void @memref_test() !dbg !3 {
  %1 = alloca i64, i64 ptrtoint (i64* getelementptr (i64, i64* null, i64 1) to i64), align 8, !dbg !7
  %2 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } undef, i64* %1, 0, !dbg !9
  %3 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %2, i64* %1, 1, !dbg !10
  %4 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %3, i64 0, 2, !dbg !11
  %5 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %4, i64 1, 3, 0, !dbg !12
  %6 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %5, i64 1, 4, 0, !dbg !13
  store i64 42, i64* %1, align 4, !dbg !14
  %7 = load i64, i64* %1, align 4, !dbg !15
  %8 = call i8* @malloc(i64 ptrtoint (i64* getelementptr (i64, i64* null, i64 20) to i64)), !dbg !16
  %9 = bitcast i8* %8 to i64*, !dbg !17
  %10 = ptrtoint i64* %9 to i64, !dbg !18
  %11 = add i64 %10, -1, !dbg !19
  %12 = urem i64 %11, 0, !dbg !20
  %13 = sub i64 %11, %12, !dbg !21
  %14 = inttoptr i64 %13 to i64*, !dbg !22
  %15 = insertvalue { i64*, i64*, i64, [2 x i64], [2 x i64] } undef, i64* %9, 0, !dbg !23
  %16 = insertvalue { i64*, i64*, i64, [2 x i64], [2 x i64] } %15, i64* %14, 1, !dbg !24
  %17 = insertvalue { i64*, i64*, i64, [2 x i64], [2 x i64] } %16, i64 0, 2, !dbg !25
  %18 = insertvalue { i64*, i64*, i64, [2 x i64], [2 x i64] } %17, i64 10, 3, 0, !dbg !26
  %19 = insertvalue { i64*, i64*, i64, [2 x i64], [2 x i64] } %18, i64 2, 3, 1, !dbg !27
  %20 = insertvalue { i64*, i64*, i64, [2 x i64], [2 x i64] } %19, i64 2, 4, 0, !dbg !28
  %21 = insertvalue { i64*, i64*, i64, [2 x i64], [2 x i64] } %20, i64 1, 4, 1, !dbg !29
  %22 = add i64 84, %7, !dbg !30
  %23 = getelementptr i64, i64* %14, i64 %22, !dbg !31
  store i64 42, i64* %23, align 4, !dbg !32
  %24 = bitcast i64* %1 to i8*, !dbg !33
  call void @free(i8* %24), !dbg !34
  %25 = bitcast i64* %9 to i8*, !dbg !35
  call void @free(i8* %25), !dbg !36
  ret void, !dbg !37
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "memref_test", linkageName: "memref_test", scope: null, file: !4, line: 5, type: !5, scopeLine: 5, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "<stdin>", directory: "/home/prathamesh/xdsl_fork/xdsl/tests")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 29, column: 11, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 31, column: 11, scope: !8)
!10 = !DILocation(line: 32, column: 11, scope: !8)
!11 = !DILocation(line: 34, column: 11, scope: !8)
!12 = !DILocation(line: 35, column: 11, scope: !8)
!13 = !DILocation(line: 36, column: 11, scope: !8)
!14 = !DILocation(line: 38, column: 5, scope: !8)
!15 = !DILocation(line: 39, column: 11, scope: !8)
!16 = !DILocation(line: 49, column: 11, scope: !8)
!17 = !DILocation(line: 50, column: 11, scope: !8)
!18 = !DILocation(line: 51, column: 11, scope: !8)
!19 = !DILocation(line: 54, column: 11, scope: !8)
!20 = !DILocation(line: 55, column: 11, scope: !8)
!21 = !DILocation(line: 56, column: 11, scope: !8)
!22 = !DILocation(line: 57, column: 11, scope: !8)
!23 = !DILocation(line: 59, column: 11, scope: !8)
!24 = !DILocation(line: 60, column: 11, scope: !8)
!25 = !DILocation(line: 62, column: 11, scope: !8)
!26 = !DILocation(line: 63, column: 11, scope: !8)
!27 = !DILocation(line: 64, column: 11, scope: !8)
!28 = !DILocation(line: 65, column: 11, scope: !8)
!29 = !DILocation(line: 66, column: 11, scope: !8)
!30 = !DILocation(line: 69, column: 11, scope: !8)
!31 = !DILocation(line: 70, column: 11, scope: !8)
!32 = !DILocation(line: 71, column: 5, scope: !8)
!33 = !DILocation(line: 72, column: 11, scope: !8)
!34 = !DILocation(line: 73, column: 5, scope: !8)
!35 = !DILocation(line: 74, column: 11, scope: !8)
!36 = !DILocation(line: 75, column: 5, scope: !8)
!37 = !DILocation(line: 76, column: 5, scope: !8)
