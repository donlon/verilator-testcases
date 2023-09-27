// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

module t ();
  sub #(
    .COUNT(10),
    .NOT_PARAMETER_BUT_LOCALPARAM(100)
  ) i_sub();

  initial begin
    $write("*-* All Finished *-*\n");
    $finish;
  end
endmodule

module sub # (
  parameter COUNT = 10
);
  for (genvar i = 0; i < COUNT; i++)
    parameter NOT_PARAMETER_BUT_LOCALPARAM = i;
endmodule
