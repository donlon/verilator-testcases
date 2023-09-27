// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2020 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

`define checks(gotv,expv) $display(`"gotv: `", gotv)

interface intf #(parameter A=1) ;

endinterface

package pkg;
  class cls#(parameter A=0);

    `ifndef VERILATOR
    class ncls#(parameter A=0);
    endclass
    `endif
  endclass

class cls2#(parameter type A=int);
  endclass
endpackage

module t(/*AUTOARG*/);
/*
   initial begin
     $display("module t 1");
     `checks($typename(cls#()::ncls), "");
     `checks($typename(cls#(100)::ncls), "");
     `checks($typename(cls#()::ncls#(100)), "");
   end
*/
   real r;
   logic l;
   typedef bit mybit_t;
   mybit_t [2:0] bitp20;
   mybit_t bitu32 [3:2];
   mybit_t bitu31 [3:1][4:5];

  enum logic [1:0] {
    s0, s1, s2, s3
  } e0;

  parameter enum logic [1:0] {
    pea_s0, pea_s1, pea_s2, pea_s3
  } PARAM_ENUM_ANON = pea_s3;

  struct {
    int a;
    pkg::cls #(pea_s3) b;
  } struct0;

  struct packed {
    int a;
    //pkg::cls #(s3) b;
  } struct1;

  // TODO: union

  class cls#(parameter A=0);

    `ifndef VERILATOR
    class ncls#(parameter A=0);
    endclass
    `endif
  endclass

  class cls2#(parameter type A = int);
  endclass

  cls a;
  cls #(1)b;
  cls #(10)c;
  cls2 d;
  cls2 #(int)e;
  //cls2 #(type(c))f; // Typedef not linked

  intf #(10)i1();
  //virtual intf #(10)i2; // Pin not under instance

  //v i_v;

   initial begin
     $display("module t 2");
      `checks($typename(real), "real");
      `checks($typename(bit), "bit");
      `checks($typename(int), "int");
      `checks($typename(logic), "logic");
      `checks($typename(string), "string");

      `checks($typename(r), "real");
      `checks($typename(l), "logic");
      `checks($typename(mybit_t), "bit");
      `checks($typename(bitp20), "bit[2:0]");
      `checks($typename(bitu32), "bit$[3:2]");
      `checks($typename(bitu31), "bit$[3:1][4:5]");
     `checks($typename(pea_s3), "");
     `checks($typename(cls), "");
     `checks($typename(e0), "");
     `checks($typename(struct0), "");
     `checks($typename(struct1), "");
     //`checks($typename(pkg::cls2#(type(struct1))), ""); // Typedef not linked
     `checks($typename(a), ""); // CLASSREFDTYPE 'cls'
     `checks($typename(b), "");
     `checks($typename(c), "");
     `checks($typename(d), "");
     `checks($typename(e), "");
    // `checks($typename(f), "");
     `checks($typename(i1), "");
     //`checks($typename(i2), "");
/*
     `checks($typename(cls#()::ncls), "");
     `checks($typename(cls#(100)::ncls), "");
     `checks($typename(cls#()::ncls#(100)), "");
     `checks($typename(pkg::cls#()::ncls), "");
     `checks($typename(pkg::cls#(100)::ncls), "");
     `checks($typename(pkg::cls#()::ncls#(100)), "");*/
     //`checks($typename(i_v), "");
      $write("*-* All Finished *-*\n");
      $finish;
   end



endmodule