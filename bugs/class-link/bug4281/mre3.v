// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2020 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

`define checks(gotv,expv) do if ((gotv) != (expv)) begin $write("%%Error: %s:%0d:  got='%s' exp='%s'\n", `__FILE__,`__LINE__, (gotv), (expv)); $stop; end while(0);

// See also t_class_param.v

module t (/*AUTOARG*/);
    class SelfRefClassTypeParam #(type T=logic);
       typedef SelfRefClassTypeParam #(int) self_int_t;
       T field;
    endclass

    class SelfRefClassIntParam #(int P=1);
       typedef SelfRefClassIntParam #(10) self_int_t;
    endclass

   SelfRefClassTypeParam src_logic;
   SelfRefClassTypeParam#()::self_int_t src_int;
   SelfRefClassIntParam src1;
   SelfRefClassIntParam#()::self_int_t src10;
   initial begin
      src_int = new;
      src_logic = new;
      src1 = new;
      src10 = new;

      if ($bits(src_logic.field) != 1) $stop;
      if ($bits(src_int.field) != 32) $stop;
      if (src1.P != 1) $stop;
      if (src10.P != 10) $stop;

      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
