// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

// bug1593

interface simple_bus #(
  parameter PARAMETER = 0
);
  parameter PARAMETER_X = PARAMETER;
  parameter PARAMETER_XX = 1000 + PARAMETER;
  localparam PARAMETER_Y = PARAMETER_X * 2 + PARAMETER_XX;
  localparam PARAMETER_YY = 1000 + PARAMETER_XX;

  logic a;
  modport mp (input a);
endinterface

module t ();
  simple_bus #(.PARAMETER(100)) intf();

  logic [99:0] a;
  sub #(.PARAM_3(1000)) i_sub(.intf, .in_a(a));
  initial begin
    if (intf.PARAMETER != 100) $stop;
    if (intf.PARAMETER_X != 100) $stop;
    if (intf.PARAMETER_XX != 1100) $stop;
    if (intf.PARAMETER_Y != 1300) $stop;
    if (intf.PARAMETER_YY != 2100) $stop;

    if (i_sub.intf_inner1.PARAMETER != 100) $stop;
    if (i_sub.intf_inner1.PARAMETER_X != 100) $stop;
    if (i_sub.intf_inner1.PARAMETER_XX != 1100) $stop;
    if (i_sub.intf_inner1.PARAMETER_Y != 1300) $stop;
    if (i_sub.intf_inner1.PARAMETER_YY != 2100) $stop;

    //$write("*-* All Finished *-*\n");
    //$finish;
  end
endmodule

module sub # (
  // VCS/Questa: OK
  // xmelab: *E,NOTDOT (./testbench.sv,49|23): Hierarchical name ('intf.PARAMETER') not allowed within a constant expression [4(IEEE)].
  // ERROR VCP2639 "Parameter initial value cannot contain external references: intf.PARAMETER." "testbench.sv" 49  2
  parameter INTF_PARAM = intf.PARAMETER
) (
  simple_bus.mp intf,
  input [intf.PARAMETER-1:0] in_a
);
  simple_bus #(.PARAMETER(intf.PARAMETER)) intf_inner1();
  simple_bus #(.PARAMETER(intf.PARAMETER + 100)) intf_inner2();

  parameter PARAM_2 = intf_inner2.PARAMETER; // OK

  // VCS: not overrided
  // Questa: ** Error (suppressible): testbench.sv(25): (vopt-3013) A parameter override is not allowed for localparam 'PARAM_3'.
  // xmelab: *E,CUPASNA (./testbench.sv,25|15): Illegal override of local parameter 'PARAM_3'.
  parameter PARAM_3 = intf_inner2.PARAMETER; // became localparam?

  // simple_bus #(.PARAMETER(intf.PARAMETER + 2)) intf_inner2();
  initial begin
    $info ("INTF_PARAM = %0d", INTF_PARAM);
    $info ("PARAM_2 = %0d", PARAM_2);
    $info ("PARAM_3 = %0d", PARAM_3);
    //if (simple.PARAMETER != 7) $stop;
    //$write("*-* All Finished *-*\n");
    //$finish;
  end
endmodule
