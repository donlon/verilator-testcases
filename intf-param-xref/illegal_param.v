// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

package pkg;
    parameter PARAM_A = 10;
endpackage

module t ();
  sub #(
    .NOT_PARAMETER_BUT_LOCALPARAM(100)
  ) i_sub();

  initial begin
    $write("*-* All Finished *-*\n");
    $ex;
  end
endmodule

interface sub # (
//    parameter a=1
) ();
  parameter NOT_PARAMETER_BUT_LOCALPARAM = 10;
endinterface
