// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2023 by Antmicro Ltd.
// SPDX-License-Identifier: CC0-1.0

class Foo #(int A = 0);
endclass

class Bar #(int B = 10);
    Foo#(B) foo;
endclass

module t;
    typedef Bar#() bar_default_t;
endmodule : t

typedef Bar#(100) bar_short_t;
