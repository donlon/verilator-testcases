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

class Baz;
   Bar#(logic[7:0]) bar_string; // not in class: good
endclass

// Baz inside t, bar_default_t outside t: ok
typedef Bar#() bar_default_t;

module t;
endmodule : t


