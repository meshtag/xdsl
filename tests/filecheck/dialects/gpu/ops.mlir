// RUN: XDSL_ROUNDTRIP

builtin.module attributes {"gpu.container_module"} {
    "gpu.module"() ({
        func.func @kernel() {
            %n = arith.constant 13 : index
            %one = arith.constant 1 : index

            %memref = "memref.alloc"() {"alignment" = 0 : i64, "operand_segment_sizes" = array<i32: 0, 0>} : () -> memref<10x10xi32>
            %unranked = "memref.cast"(%memref) : (memref<10x10xi32>) -> memref<*xi32>
            "gpu.host_register"(%unranked) : (memref<*xi32>) -> ()
            "gpu.host_unregister"(%unranked) : (memref<*xi32>) -> ()

            %threadidx = "gpu.thread_id"() {"dimension" = #gpu<dim x>} : () -> index
            %threadidy = "gpu.thread_id"() {"dimension" = #gpu<dim y>} : () -> index
            %threadidz = "gpu.thread_id"() {"dimension" = #gpu<dim z>} : () -> index

            %blockdimx = "gpu.block_dim"() {"dimension" = #gpu<dim x>} : () -> index
            %blockdimy = "gpu.block_dim"() {"dimension" = #gpu<dim y>} : () -> index
            %blockdimz = "gpu.block_dim"() {"dimension" = #gpu<dim z>} : () -> index

            %blockidx = "gpu.block_id"() {"dimension" = #gpu<dim x>} : () -> index
            %blockidy = "gpu.block_id"() {"dimension" = #gpu<dim y>} : () -> index
            %blockidz = "gpu.block_id"() {"dimension" = #gpu<dim z>} : () -> index

            %globalidx = "gpu.global_id"() {"dimension" = #gpu<dim x>} : () -> index
            %globalidy = "gpu.global_id"() {"dimension" = #gpu<dim y>} : () -> index
            %globalidz = "gpu.global_id"() {"dimension" = #gpu<dim z>} : () -> index

            %griddimx = "gpu.grid_dim"() {"dimension" = #gpu<dim x>} : () -> index
            %griddimy = "gpu.grid_dim"() {"dimension" = #gpu<dim y>} : () -> index
            %griddimz = "gpu.grid_dim"() {"dimension" = #gpu<dim z>} : () -> index

            %gmemref = "gpu.alloc"() {"operand_segment_sizes" = array<i32: 0, 0, 0>} : () -> memref<10x10xi32>
            %gdmemref = "gpu.alloc"(%griddimx, %griddimy,%griddimz) {"operand_segment_sizes" = array<i32: 0, 3, 0>}: (index, index, index) -> memref<?x?x?xf64>

            "gpu.memcpy"(%memref, %gmemref) {"operand_segment_sizes" = array<i32: 0, 1, 1>} : (memref<10x10xi32>, memref<10x10xi32>) -> ()

            "gpu.dealloc"(%gdmemref) {"operand_segment_sizes" = array<i32: 0, 1>} : (memref<?x?x?xf64>) -> ()

            %laneid = "gpu.lane_id"() : () -> index
            %numsubgroups = "gpu.num_subgroups"() : () -> index

            %dev = arith.constant 0 : i32
            "gpu.set_default_device"(%dev) : (i32) -> ()

            %subgroupid = "gpu.subgroup_id"() : () -> index
            %subgroupsize = "gpu.subgroup_size"() : () -> index

            %globalprodx = "gpu.all_reduce"(%globalidx) ({
            }) {"op" = #gpu<all_reduce_op mul>} : (index) -> index

            %globalsumy = "gpu.all_reduce"(%globalidy) ({
            ^bb(%lhs : index, %rhs : index):
                %sum = arith.addi %lhs, %rhs : index
                "gpu.yield"(%sum) : (index) -> ()
            }) : (index) -> index

            "gpu.launch"(%one, %one, %one, %n, %one, %one) ({
            ^bb0(%bx : index, %by : index, %bz : index,
                %tx : index, %ty : index, %tz : index,
                %num_bx : index, %num_by : index, %num_bz : index,
                %num_tx : index, %num_ty : index, %num_tz : index):
                %sum = "gpu.all_reduce"(%tx) ({
                }) {"op" = #gpu<all_reduce_op add>} : (index) -> index
                %final = arith.muli %sum, %one : index
                "gpu.terminator"() : () -> ()
            }) {"operand_segment_sizes" = array<i32: 0, 1, 1, 1, 1, 1, 1, 0>} : (index, index, index, index, index, index) -> ()
            "gpu.launch_func"(%n, %n, %n, %n, %n, %n, %dev, %n) {"operand_segment_sizes" = array<i32: 0, 1, 1, 1, 1, 1, 1, 1, 1>, "kernel" = @gpu::@foo} : (index, index, index, index, index, index, i32, index) -> ()

            func.return
        }
        "gpu.func"() ({
        ^bb0(%arg0: index):
            "gpu.return"() : () -> ()
        }) {"sym_name" = "foo", "kernel", "function_type" = (index) -> (), "gpu.known_block_size" = array<i32: 128, 1, 1>, "gpu.known_grid_size" = array<i32: 128, 1, 1>} : () -> ()
        "gpu.module_end"() : () -> ()
    }) {"sym_name" = "gpu"} : () -> ()
}

// CHECK:      builtin.module attributes {"gpu.container_module"} {
// CHECK-NEXT:     "gpu.module"() ({
// CHECK-NEXT:         func.func @kernel() {
// CHECK-NEXT:             %{{.*}} = arith.constant 13 : index
// CHECK-NEXT:             %{{.*}} = arith.constant 1 : index

// CHECK-NEXT:             %{{.*}} = "memref.alloc"() {"alignment" = 0 : i64, "operand_segment_sizes" = array<i32: 0, 0>} : () -> memref<10x10xi32>
// CHECK-NEXT:             %{{.*}} = "memref.cast"(%{{.*}}) : (memref<10x10xi32>) -> memref<*xi32>
// CHECK-NEXT:             "gpu.host_register"(%{{.*}}) : (memref<*xi32>) -> ()
// CHECK-NEXT:             "gpu.host_unregister"(%{{.*}}) : (memref<*xi32>) -> ()

// CHECK-NEXT:             %{{.*}} = "gpu.thread_id"() {"dimension" = #gpu<dim x>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.thread_id"() {"dimension" = #gpu<dim y>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.thread_id"() {"dimension" = #gpu<dim z>} : () -> index

// CHECK-NEXT:             %{{.*}} = "gpu.block_dim"() {"dimension" = #gpu<dim x>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.block_dim"() {"dimension" = #gpu<dim y>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.block_dim"() {"dimension" = #gpu<dim z>} : () -> index

// CHECK-NEXT:             %{{.*}} = "gpu.block_id"() {"dimension" = #gpu<dim x>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.block_id"() {"dimension" = #gpu<dim y>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.block_id"() {"dimension" = #gpu<dim z>} : () -> index

// CHECK-NEXT:             %{{.*}} = "gpu.global_id"() {"dimension" = #gpu<dim x>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.global_id"() {"dimension" = #gpu<dim y>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.global_id"() {"dimension" = #gpu<dim z>} : () -> index

// CHECK-NEXT:             %{{.*}} = "gpu.grid_dim"() {"dimension" = #gpu<dim x>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.grid_dim"() {"dimension" = #gpu<dim y>} : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.grid_dim"() {"dimension" = #gpu<dim z>} : () -> index

// CHECK-NEXT:             %gmemref = "gpu.alloc"() {"operand_segment_sizes" = array<i32: 0, 0, 0>} : () -> memref<10x10xi32>
// CHECK-NEXT:             %gdmemref = "gpu.alloc"(%griddimx, %griddimy, %griddimz) {"operand_segment_sizes" = array<i32: 0, 3, 0>} : (index, index, index) -> memref<?x?x?xf64>

// CHECK-NEXT:            "gpu.memcpy"(%memref, %gmemref) {"operand_segment_sizes" = array<i32: 0, 1, 1>} : (memref<10x10xi32>, memref<10x10xi32>) -> ()

// CHECK-NEXT:            "gpu.dealloc"(%gdmemref) {"operand_segment_sizes" = array<i32: 0, 1>} : (memref<?x?x?xf64>) -> ()

// CHECK-NEXT:             %{{.*}} = "gpu.lane_id"() : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.num_subgroups"() : () -> index

// CHECK-NEXT:             %{{.*}} = arith.constant 0 : i32
// CHECK-NEXT:             "gpu.set_default_device"(%{{.*}}) : (i32) -> ()

// CHECK-NEXT:             %{{.*}} = "gpu.subgroup_id"() : () -> index
// CHECK-NEXT:             %{{.*}} = "gpu.subgroup_size"() : () -> index

// CHECK-NEXT:             %{{.*}} = "gpu.all_reduce"(%{{.*}}) ({
// CHECK-NEXT:             }) {"op" = #gpu<all_reduce_op mul>} : (index) -> index

// CHECK-NEXT:             %{{.*}} = "gpu.all_reduce"(%{{.*}}) ({
// CHECK-NEXT:             ^{{.*}}(%{{.*}} : index, %{{.*}} : index):
// CHECK-NEXT:                 %{{.*}} = arith.addi %{{.*}}, %{{.*}} : index
// CHECK-NEXT:                 "gpu.yield"(%{{.*}}) : (index) -> ()
// CHECK-NEXT:             }) : (index) -> index

// CHECK-NEXT:             "gpu.launch"(%{{.*}}, %{{.*}}, %{{.*}}, %{{.*}}, %{{.*}}, %{{.*}}) ({
// CHECK-NEXT:             ^{{.*}}(%{{.*}} : index, %{{.*}} : index, %{{.*}} : index,
// CHECK-SAME:                 %{{.*}} : index, %{{.*}} : index, %{{.*}} : index,
// CHECK-SAME:                 %{{.*}} : index, %{{.*}} : index, %{{.*}} : index,
// CHECK-SAME:                 %{{.*}} : index, %{{.*}} : index, %{{.*}} : index):
// CHECK-NEXT:                 %{{.*}} = "gpu.all_reduce"(%{{.*}}) ({
// CHECK-NEXT:                 }) {"op" = #gpu<all_reduce_op add>} : (index) -> index
// CHECK-NEXT:                 %{{.*}} = arith.muli %{{.*}}, %{{.*}} : index
// CHECK-NEXT:                 "gpu.terminator"() : () -> ()
// CHECK-NEXT:             }) {"operand_segment_sizes" = array<i32: 0, 1, 1, 1, 1, 1, 1, 0>} : (index, index, index, index, index, index) -> ()
// CHECK-NEXT:             "gpu.launch_func"(%{{.*}}, %{{.*}}, %{{.*}}, %{{.*}}, %{{.*}}, %{{.*}}, %{{.*}}, %{{.*}}) {"operand_segment_sizes" = array<i32: 0, 1, 1, 1, 1, 1, 1, 1, 1>, "kernel" = @gpu::@foo} : (index, index, index, index, index, index, i32, index) -> ()

// CHECK-NEXT:             func.return
// CHECK-NEXT:         }
// CHECK-NEXT:         "gpu.func"() ({
// CHECK-NEXT:         ^{{.*}}(%{{.*}}: index):
// CHECK-NEXT:             "gpu.return"() : () -> ()
// CHECK-NEXT:         }) {"sym_name" = "foo", "kernel", "function_type" = (index) -> (), "gpu.known_block_size" = array<i32: 128, 1, 1>, "gpu.known_grid_size" = array<i32: 128, 1, 1>} : () -> ()
// CHECK-NEXT:          "gpu.module_end"() : () -> ()
// CHECK-NEXT:     }) {"sym_name" = "gpu"} : () -> ()

// CHECK-NEXT: }
