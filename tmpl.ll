; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare i8* @malloc(i64)

declare void @free(i8*)

declare void @printNewline()

declare void @printClose()

declare void @printComma()

declare void @printOpen()

declare void @printU64(i64)

define void @vector_test() !dbg !3 {
  %1 = alloca i64, i64 ptrtoint (i64* getelementptr (i64, i64* null, i64 4) to i64), align 8, !dbg !7
  %2 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } undef, i64* %1, 0, !dbg !9
  %3 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %2, i64* %1, 1, !dbg !10
  %4 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %3, i64 0, 2, !dbg !11
  %5 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %4, i64 4, 3, 0, !dbg !12
  %6 = insertvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %5, i64 1, 4, 0, !dbg !13
  %7 = extractvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %6, 1, !dbg !14
  %8 = getelementptr i64, i64* %7, i64 0, !dbg !15
  %9 = bitcast i64* %8 to <2 x i64>*, !dbg !16
  %10 = load <2 x i64>, <2 x i64>* %9, align 8, !dbg !17
  %11 = extractvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %6, 1, !dbg !18
  %12 = getelementptr i64, i64* %11, i64 0, !dbg !19
  %13 = bitcast i64* %12 to <2 x i64>*, !dbg !20
  store <2 x i64> %10, <2 x i64>* %13, align 8, !dbg !21
  call void @printOpen(), !dbg !22
  %14 = extractelement <2 x i64> %10, i64 0, !dbg !23
  call void @printU64(i64 %14), !dbg !24
  call void @printComma(), !dbg !25
  %15 = extractelement <2 x i64> %10, i64 1, !dbg !26
  call void @printU64(i64 %15), !dbg !27
  call void @printClose(), !dbg !28
  call void @printNewline(), !dbg !29
  %16 = bitcast i64* %1 to i8*, !dbg !30
  call void @free(i8* %16), !dbg !31
  ret void, !dbg !32
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "vector_test", linkageName: "vector_test", scope: null, file: !4, line: 8, type: !5, scopeLine: 8, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "<stdin>", directory: "/home/prathamesh/xdsl_fork/xdsl")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 15, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 17, column: 10, scope: !8)
!10 = !DILocation(line: 18, column: 10, scope: !8)
!11 = !DILocation(line: 20, column: 11, scope: !8)
!12 = !DILocation(line: 21, column: 11, scope: !8)
!13 = !DILocation(line: 22, column: 11, scope: !8)
!14 = !DILocation(line: 23, column: 11, scope: !8)
!15 = !DILocation(line: 24, column: 11, scope: !8)
!16 = !DILocation(line: 25, column: 11, scope: !8)
!17 = !DILocation(line: 26, column: 11, scope: !8)
!18 = !DILocation(line: 27, column: 11, scope: !8)
!19 = !DILocation(line: 28, column: 11, scope: !8)
!20 = !DILocation(line: 29, column: 11, scope: !8)
!21 = !DILocation(line: 30, column: 5, scope: !8)
!22 = !DILocation(line: 31, column: 5, scope: !8)
!23 = !DILocation(line: 33, column: 11, scope: !8)
!24 = !DILocation(line: 34, column: 5, scope: !8)
!25 = !DILocation(line: 35, column: 5, scope: !8)
!26 = !DILocation(line: 37, column: 11, scope: !8)
!27 = !DILocation(line: 38, column: 5, scope: !8)
!28 = !DILocation(line: 39, column: 5, scope: !8)
!29 = !DILocation(line: 40, column: 5, scope: !8)
!30 = !DILocation(line: 41, column: 11, scope: !8)
!31 = !DILocation(line: 42, column: 5, scope: !8)
!32 = !DILocation(line: 43, column: 5, scope: !8)
