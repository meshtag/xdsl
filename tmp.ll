; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@g = global [1 x i64] zeroinitializer

declare ptr @malloc(i64)

declare void @free(ptr)

define void @memref_test() {
  %1 = alloca i64, i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1) to i64), align 8
  store i64 42, ptr %1, align 4
  %2 = load i64, ptr %1, align 4
  %3 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 20) to i64))
  %4 = ptrtoint ptr %3 to i64
  %5 = add i64 %4, -1
  %6 = urem i64 %5, 0
  %7 = sub i64 %5, %6
  %8 = inttoptr i64 %7 to ptr
  %9 = add i64 84, %2
  %10 = getelementptr i64, ptr %8, i64 %9
  store i64 42, ptr %10, align 4
  call void @free(ptr %1)
  call void @free(ptr %3)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
