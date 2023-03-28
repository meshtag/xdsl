OP print
%0 : !f64 = stencil.access(%<UNKNOWN> : !stencil.temp<[66 : !i64, 66 : !i64, 63 : !i64], !f64>) ["offset" = !stencil.index<[0 : !i64, 0 : !i64, 0 : !i64]>]

OP Clone Print
%0 : !f64 = stencil.access(%<UNKNOWN> : !stencil.temp<[66 : !i64, 66 : !i64, 63 : !i64], !f64>) ["offset" = !stencil.index<[0 : !i64, 0 : !i64, 0 : !i64]>]




OP print
%0 : !f64 = arith.subf(%<UNKNOWN> : !f64, %<UNKNOWN> : !f64)

OP Clone Print
%0 : !f64 = arith.subf(%<UNKNOWN> : !f64, %<UNKNOWN> : !f64)




OP print
%0 : !stencil.result<!f64> = stencil.store_result(%<UNKNOWN> : !f64)

OP Clone Print
%0 : !stencil.result<!f64> = stencil.store_result(%<UNKNOWN> : !f64)




OP print
stencil.return(%<UNKNOWN> : !stencil.result<!f64>)

OP Clone Print
stencil.return(%<UNKNOWN> : !stencil.result<!f64>)







%0 : !stencil.temp<[64 : !i64, 64 : !i64, 60 : !i64], !f64> = stencil.apply(%<UNKNOWN> : !stencil.temp<[66 : !i64, 66 : !i64, 63 : !i64], !f64>) ["lb" = !stencil.index<[0 : !i64, 0 : !i64, 0 : !i64]>, "ub" = !stencil.index<[64 : !i64, 64 : !i64, 60 : !i64]>] {
----------------------------------------------------------------------------^^^^^^^^^^-----------
| ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
-------------------------------------------------------------------------------------------------
^0(%1 : !stencil.temp<[66 : !i64, 66 : !i64, 63 : !i64], !f64>):
  %2 : !f64 = stencil.access(%<UNKNOWN> : !stencil.temp<[66 : !i64, 66 : !i64, 63 : !i64], !f64>) ["offset" = !stencil.index<[0 : !i64, 0 : !i64, 0 : !i64]>]
  ---------------------------^^^^^^^^^^------------------------------------------------------------
  | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
  -------------------------------------------------------------------------------------------------
  %3 : !f64 = stencil.access(%<UNKNOWN> : !stencil.temp<[66 : !i64, 66 : !i64, 63 : !i64], !f64>) ["offset" = !stencil.index<[0 : !i64, 2 : !i64, 3 : !i64]>]
  ---------------------------^^^^^^^^^^------------------------------------------------------------
  | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
  -------------------------------------------------------------------------------------------------
  %4 : !f64 = stencil.access(%<UNKNOWN> : !stencil.temp<[66 : !i64, 66 : !i64, 63 : !i64], !f64>) ["offset" = !stencil.index<[2 : !i64, 2 : !i64, 3 : !i64]>]
  ---------------------------^^^^^^^^^^------------------------------------------------------------
  | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
  -------------------------------------------------------------------------------------------------
  %5 : !f64 = arith.addf(%<UNKNOWN> : !f64, %<UNKNOWN> : !f64)
  -----------------------^^^^^^^^^^----------------------------------------------------------------
  | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
  -------------------------------------------------------------------------------------------------
  ------------------------------------------^^^^^^^^^^---------------------------------------------
  | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
  -------------------------------------------------------------------------------------------------
  %6 : !f64 = arith.subf(%<UNKNOWN> : !f64, %<UNKNOWN> : !f64)
  -----------------------^^^^^^^^^^----------------------------------------------------------------
  | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
  -------------------------------------------------------------------------------------------------
  ------------------------------------------^^^^^^^^^^---------------------------------------------
  | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
  -------------------------------------------------------------------------------------------------
  %7 : !stencil.result<!f64> = stencil.store_result(%<UNKNOWN> : !f64)
  --------------------------------------------------^^^^^^^^^^-------------------------------------
  | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
  -------------------------------------------------------------------------------------------------
  stencil.return(%<UNKNOWN> : !stencil.result<!f64>)
  ---------------^^^^^^^^^^------------------------------------------------------------------------
  | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
  -------------------------------------------------------------------------------------------------
}
"builtin.module"() ({
  "func.func"() ({
  ^0(%arg0 : !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>, %arg1 : !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>):
    %0 = "stencil.cast"(%arg0) {"lb" = #stencil.index<[-3 : i64, -3 : i64, -3 : i64]>, "ub" = #stencil.index<[67 : i64, 67 : i64, 67 : i64]>} : (!stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>) -> !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>
    %1 = "stencil.cast"(%arg1) {"lb" = #stencil.index<[-3 : i64, -3 : i64, -3 : i64]>, "ub" = #stencil.index<[67 : i64, 67 : i64, 67 : i64]>} : (!stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>) -> !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>
    %2 = "stencil.load"(%0) {"lb" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>, "ub" = #stencil.index<[66 : i64, 66 : i64, 63 : i64]>} : (!stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>) -> !stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>
    %3 = "stencil.apply"(%2) ({
    ^1(%4 : !stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>):
      %5 = "stencil.access"(%<UNKNOWN>) {"offset" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> f64
      ----------------------^^^^^^^^^^-----------------------------------------------------------------
      | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
      -------------------------------------------------------------------------------------------------
      %6 = "stencil.access"(%<UNKNOWN>) {"offset" = #stencil.index<[0 : i64, 2 : i64, 3 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> f64
      ----------------------^^^^^^^^^^-----------------------------------------------------------------
      | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
      -------------------------------------------------------------------------------------------------
      %7 = "stencil.access"(%<UNKNOWN>) {"offset" = #stencil.index<[2 : i64, 2 : i64, 3 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> f64
      ----------------------^^^^^^^^^^-----------------------------------------------------------------
      | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
      -------------------------------------------------------------------------------------------------
      %8 = "arith.addf"(%<UNKNOWN>, %<UNKNOWN>) : (f64, f64) -> f64
      ------------------^^^^^^^^^^---------------------------------------------------------------------
      | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
      -------------------------------------------------------------------------------------------------
      ------------------------------^^^^^^^^^^---------------------------------------------------------
      | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
      -------------------------------------------------------------------------------------------------
      %9 = "arith.subf"(%<UNKNOWN>, %<UNKNOWN>) : (f64, f64) -> f64
      ------------------^^^^^^^^^^---------------------------------------------------------------------
      | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
      -------------------------------------------------------------------------------------------------
      ------------------------------^^^^^^^^^^---------------------------------------------------------
      | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
      -------------------------------------------------------------------------------------------------
      %10 = "stencil.store_result"(%<UNKNOWN>) : (f64) -> !stencil.result<f64>
      -----------------------------^^^^^^^^^^----------------------------------------------------------
      | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
      -------------------------------------------------------------------------------------------------
      "stencil.return"(%<UNKNOWN>) : (!stencil.result<f64>) -> ()
      -----------------^^^^^^^^^^----------------------------------------------------------------------
      | ERROR: SSAValue is not part of the IR, are you sure all operations are added before their uses?
      -------------------------------------------------------------------------------------------------
    }) {"lb" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>, "ub" = #stencil.index<[64 : i64, 64 : i64, 60 : i64]>} : (!stencil.temp<[66 : i64, 66 : i64, 63 : i64], f64>) -> !stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>
    "stencil.store"(%3, %1) {"lb" = #stencil.index<[0 : i64, 0 : i64, 0 : i64]>, "ub" = #stencil.index<[64 : i64, 64 : i64, 60 : i64]>} : (!stencil.temp<[64 : i64, 64 : i64, 60 : i64], f64>, !stencil.field<[70 : i64, 70 : i64, 70 : i64], f64>) -> ()
    "func.return"() : () -> ()
  }) {"function_type" = (!stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>, !stencil.field<[-1 : i64, -1 : i64, -1 : i64], f64>) -> (), "sym_name" = "simple_stencil_inlining"} : () -> ()
}) : () -> ()


