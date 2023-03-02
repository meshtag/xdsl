builtin.module() {
  func.func() ["sym_name" = "stencil_laplace", "function_type" = !fun<[!stencil.field<[-1 : !i32, -1 : !i32, -1 : !i32], !f64>, !stencil.field<[-1 : !i32, -1 : !i32, -1 : !i32], !f64>], []>, "sym_visibility" = "private"] {
  ^0(%0 : !stencil.field<[-1 : !i32, -1 : !i32, -1 : !i32], !f64>, %1 : !stencil.field<[-1 : !i32, -1 : !i32, -1 : !i32], !f64>):
    %2 : !stencil.field<[72 : !i32, 72 : !i32, 72 : !i32], !f64> = stencil.cast(%0 : !stencil.field<[-1 : !i32, -1 : !i32, -1 : !i32], !f64>) ["lb" = !stencil.index<[-4 : !i32, -4 : !i32, -4 : !i32]>, "ub" = !stencil.index<[68 : !i32, 68 : !i32, 68 : !i32]>]
    %3 : !stencil.field<[72 : !i32, 72 : !i32, 72 : !i32], !f64> = stencil.cast(%1 : !stencil.field<[-1 : !i32, -1 : !i32, -1 : !i32], !f64>) ["lb" = !stencil.index<[-4 : !i32, -4 : !i32, -4 : !i32]>, "ub" = !stencil.index<[68 : !i32, 68 : !i32, 68 : !i32]>]
    %4 : !stencil.temp<[66 : !i32, 66 : !i32, 66 : !i32], !f64> = stencil.load(%2 : !stencil.field<[72 : !i32, 72 : !i32, 72 : !i32], !f64>) ["lb" = !stencil.index<[-1 : !i32, -1 : !i32, 0 : !i32]>, "ub" = !stencil.index<[65 : !i32, 65 : !i32, 64 : !i32]>]
    func.return()
  }
}

