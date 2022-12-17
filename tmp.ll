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
  %8 = bitcast i64* %7 to <2 x i64>*, !dbg !15
  %9 = load <2 x i64>, <2 x i64>* %8, align 8, !dbg !16
  %10 = extractvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %6, 1, !dbg !17
  %11 = bitcast i64* %10 to <2 x i64>*, !dbg !18
  store <2 x i64> %9, <2 x i64>* %11, align 8, !dbg !19
  %12 = extractvalue { i64*, i64*, i64, [1 x i64], [1 x i64] } %6, 1, !dbg !20
  %13 = bitcast i64* %12 to <2 x i64>*, !dbg !21
  call void @llvm.masked.store.v2i64.p0v2i64(<2 x i64> %9, <2 x i64>* %13, i32 8, <2 x i1> <i1 true, i1 true>), !dbg !22
  call void @printOpen(), !dbg !23
  %14 = extractelement <2 x i64> %9, i64 0, !dbg !24
  call void @printU64(i64 %14), !dbg !25
  call void @printComma(), !dbg !26
  %15 = extractelement <2 x i64> %9, i64 1, !dbg !27
  call void @printU64(i64 %15), !dbg !28
  call void @printClose(), !dbg !29
  call void @printNewline(), !dbg !30
  %16 = bitcast i64* %1 to i8*, !dbg !31
  call void @free(i8* %16), !dbg !32
  ret void, !dbg !33
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
declare void @llvm.masked.store.v2i64.p0v2i64(<2 x i64>, <2 x i64>*, i32 immarg, <2 x i1>) #0

attributes #0 = { argmemonly nofree nosync nounwind willreturn writeonly }

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
!19 = !DILocation(line: 28, column: 5, scope: !8)
!20 = !DILocation(line: 30, column: 11, scope: !8)
!21 = !DILocation(line: 31, column: 11, scope: !8)
!22 = !DILocation(line: 32, column: 5, scope: !8)
!23 = !DILocation(line: 33, column: 5, scope: !8)
!24 = !DILocation(line: 35, column: 11, scope: !8)
!25 = !DILocation(line: 36, column: 5, scope: !8)
!26 = !DILocation(line: 37, column: 5, scope: !8)
!27 = !DILocation(line: 39, column: 11, scope: !8)
!28 = !DILocation(line: 40, column: 5, scope: !8)
!29 = !DILocation(line: 41, column: 5, scope: !8)
!30 = !DILocation(line: 42, column: 5, scope: !8)
!31 = !DILocation(line: 43, column: 11, scope: !8)
!32 = !DILocation(line: 44, column: 5, scope: !8)
!33 = !DILocation(line: 45, column: 5, scope: !8)
