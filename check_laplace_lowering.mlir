; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @free(ptr)

declare void @printNewline()

declare void @printU64(i64)

define void @main() {
  call void @printU64(i64 2)
  call void @printNewline()
  call void @printU64(i64 3)
  call void @printNewline()
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
