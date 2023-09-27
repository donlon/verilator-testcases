// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2023 by Antmicro Ltd.
// SPDX-License-Identifier: CC0-1.0

class Foo #(type T=bit);
   int x = $bits(T);
endclass

class Bar #(type S=int) extends Foo#(S);
                             // -> Foo__Tz1
endclass

typedef Bar#() bar_default_t;
// 1: CLASSREFDTYPE 0x562256219290 <e1007> {d14aj} @dt=this@(w0)class:Bar  Bar cpkg=0x562256235a60 -> CLASS 0x562256235a60 <e610> {d11ab}  Bar  L4 [1ps]
//   1: PIN 0x562256236d00 <e1003> {d14ao}  __paramNumber1 ->UNLINKED
// ->Bar

class Baz;
   Bar#(logic[7:0]) bar_string;
   // ->Bar__Tz2
   int bar_x;
   function new;
      bar_string = new;
      bar_x = bar_string.x;
   endfunction
endclass

typedef Baz baz_t;

module t;
   initial begin
      bar_default_t bar_default = new;
      baz_t baz = new;

      if (bar_default.x != 32) $stop;
      if (baz.bar_x != 8) $stop;

      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
