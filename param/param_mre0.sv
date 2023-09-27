// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2023 by Antmicro Ltd.
// SPDX-License-Identifier: CC0-1.0

class Foo #(type T=bit); // -> int T: good
endclass

class Bar #(type S=int);
    Foo#(S) foo;
endclass

module t;
    typedef Bar#() bar_default_t;
endmodule : t

typedef Bar#(shortint) bar_short_t;
