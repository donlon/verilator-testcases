// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

module t ();
  sub #(
    .A(100)
  ) i_sub();

  initial begin
    $write("*-* All Finished *-*\n");
    $exit;
  end
endmodule

interface sub
//# (
//  parameter A=1,
//  parameter B=1
//)
 ;
 input a;
  parameter A=1;
  parameter D=1;
endinterface

