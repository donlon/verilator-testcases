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

  sub #(
    //.PARAM_3(1000)
  ) i_sub(.intf);
endmodule

module sub # (
  parameter INTF_PARAM = 1
) (
  simple_bus.mp intf
);
  simple_bus #(.PARAMETER(intf.PARAMETER)) intf_inner1();
  simple_bus #(.PARAMETER(intf.PARAMETER + 100)) intf_inner2();

  parameter PARAM_2 = intf_inner2.PARAMETER; // OK

  // VCS: not overrided
  // Questa: ** Error (suppressible): testbench.sv(25): (vopt-3013) A parameter override is not allowed for localparam 'PARAM_3'.
  // xmelab: *E,CUPASNA (./testbench.sv,25|15): Illegal override of local parameter 'PARAM_3'.
  parameter PARAM_3 = intf_inner2.PARAMETER; // became localparam?

    // With '#()'
    //     Questa: error (localparam)
    //     VCS: OK
    // With '#(parameter ...)'
    //     Questa: error (localparam)
    //     VCS: warning, not overridden
    // Without '#'
    // Questa: OK
    // VCS: OK

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
