module CPU (input logic clk);
   S s1 (clk);
endmodule // CPU

// Sequences operations in a state machine
module S (input clk);
   enum {s0, s1} state;
   always_ff @(clk)
     begin
        $write("*-* All Finished *-*\n");
        $finish;
     end
endmodule // s