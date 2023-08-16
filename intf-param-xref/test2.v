// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2017 by Johan Bjork.
// SPDX-License-Identifier: CC0-1.0

// bug1593

interface simple_bus #(
   PARAMETER = 0
);
   // parameter PARAMETER_X = PARAMETER;
   // parameter PARAMETER_XX = 1000 + PARAMETER;
   // localparam PARAMETER_Y = PARAMETER_X * 2 + PARAMETER_XX;
   // localparam PARAMETER_YY = 1000 + PARAMETER_XX;

   // logic a;
   // modport mp (input a);
endinterface

module t ();
   simple_bus
    #(.PARAMETER(100)) 
    intf();

   sub i_sub(.intf);
   // sub2 i_sub2(.intf);
   initial begin
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule


module sub (
   simple_bus/*.mp*/ intf
);
   simple_bus 
   // #(.PARAMETER(0/*intf.PARAMETER*/)) 
   intf_inner1();
   // initial begin
   //    if (simple.PARAMETER != 7) $stop;
   //    $write("*-* All Finished *-*\n");
   //    $finish;
   // end
endmodule



// module sub2 (
//    simple_bus.mp intf
// );
//    simple_bus #(.PARAMETER(intf.PARAMETER)) intf_inner1();
//    simple_bus #(.PARAMETER(intf.PARAMETER + 2)) intf_inner2(); // Keep both
//    // initial begin
//    //    if (simple.PARAMETER != 7) $stop;
//    //    $write("*-* All Finished *-*\n");
//    //    $finish;
//    // end
// endmodule
