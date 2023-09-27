// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2023 by Antmicro Ltd.
// SPDX-License-Identifier: CC0-1.0

module Foo #(int A = 0);
endmodule

interface Bar #(int B = 10);
    Foo#(B) i_foo();
endinterface

module t;
    Bar#() bar_if();
endmodule : t

typedef virtual Bar#(100) bar_if_t;
