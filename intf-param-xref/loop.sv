// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

interface simple_bus #(
  parameter PARAM_A = 0
);
  localparam PARAM_B = 1000 + PARAM_A;

  logic a;
  modport mp (input a);
endinterface

module simple_mod #(
  parameter PARAM_A = 0
);
  localparam PARAM_B = PARAM_A * 2 + 1;
endmodule

module t ();
  parameter PARAM_A = 10;

  //localparam PARAM_B_FRONT = PARAM_A + genblk_a[5].intf.PARAM_A; // OK
  localparam PARAM_B_FRONT = PARAM_A + genblk_a[2].PARAM; //   The RHS expression of the parameter could not be evaluated.

  for (genvar i = 0; i < PARAM_A; i++) begin : genblk_a
    // VCS: OK
    // Questa: OK
    // xmelab: *E,NOTDOT (./testbench.sv,28|45): Hierarchical name ('intf.PARAM_B') not allowed within a constant expression [4(IEEE)].
    localparam PARAM = i*10 + intf.PARAM_B;

    simple_bus #(.PARAM_A(100 + i)) intf();
    simple_mod #(.PARAM_A(200 + i)) mod_1();
    for (genvar j = 0; j < PARAM_A; j++) begin : genblk_b
      localparam PARAM = i*10 + j;
      simple_bus #(.PARAM_A(100 + PARAM)) mod_2();
      simple_mod #(.PARAM_A(200 + PARAM)) mod_3();
    end
    // xmelab: *E,NOTDOT (./testbench.sv,28|45): Hierarchical name ('intf.PARAM_B') not allowed within a constant expression [4(IEEE)].
    localparam PARAM_POST = i*10 + intf.PARAM_B;
  end

  // reeorder
  //localparam PARAM_C = PARAM_B; // Undefined variable

  // VCS: localparam PARAM_B = (PARAM_A + genblk_a[5].intf.PARAM_A);
  // Questa: OK
  // xmelab: *E,NOTDOT (./testbench.sv,44|56): Hierarchical name ('genblk_a[5].intf.PARAM_A') not allowed within a constant expression [4(IEEE)].
  //localparam PARAM_B = PARAM_A + genblk_a[5].intf.PARAM_A;

  // VCS: failed
  // Questa: OK
  // xmelab: *E,NOTPAR (./testbench.sv,39|79): Illegal operand for constant expression [4(IEEE)].
  `ifdef TEST_B
  for (genvar j = genblk_a[0].intf.PARAM_A; j < genblk_a[PARAM_A-2].intf.PARAM_A; j++) begin : genblk_c
    // ERROR VCP2639 "Parameter initial value cannot contain external references: j+mod.PARAM_B." "testbench.sv" 42  44
    localparam PARAM = j + mod.PARAM_B;
    simple_mod #(.PARAM_A(1000 + j)) mod();
    $info("genblk_c: j = %0d", j);
  end
  `endif

  //localparam PARAM_B = PARAM_A + genblk_c[genblk_a[0].intf.PARAM_A].PARAM;

  logic [99:0] a;
  // sub i_sub(.intf(genblk_a[0].intf), .in_a(a));
  //sub i_sub(.intf(), .in_a(a));

  initial begin
    $display("genblk_a[9].intf.PARAM_A = %0d", genblk_a[9].intf.PARAM_A);
    $display("genblk_a[9].intf.PARAM_A = %0d", genblk_a[9].mod_1.PARAM_A);
    $display("genblk_a[9].genblk_b[8].PARAM = %0d", genblk_a[9].genblk_b[8].PARAM);
    $display("genblk_a[9].genblk_b[8].mod_3.PARAM_A = %0d", genblk_a[9].genblk_b[8].mod_3.PARAM_A);
    $display(genblk_a[0].intf.PARAM_A, genblk_a[PARAM_A-8].intf.PARAM_A);

    $display(PARAM_B);
    `ifdef TEST_B
    // Questa: failed
    $display(genblk_c[genblk_a[0].intf.PARAM_A].PARAM);
    `endif

    //$write("*-* All Finished *-*\n");
    //$finish;
  end
endmodule

/*
module sub
# (
    parameter INTF_PARAM = intf.PARAM_A
) (
  	simple_bus.mp intf,
  	input [intf.PARAM_A-1:0] in_a
);
    simple_bus #(.PARAM_A(intf.PARAM_A)) intf_inner1();
    simple_bus #(.PARAM_A(intf.PARAM_A)) intf_inner2();
  	// simple_bus #(.PARAM_A(intf.PARAM_A + 2)) intf_inner2();
    initial begin
        $info ("intf_param = %0d", INTF_PARAM);
        //if (simple.PARAM_A != 7) $stop;
        //$write("*-* All Finished *-*\n");
        //$finish;
   end
endmodule
*/