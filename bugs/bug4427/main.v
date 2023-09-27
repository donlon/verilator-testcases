`timescale 1ns / 10ps
 // `default_nettype none

// case: SAMPLE_SIZE = 50
//      BIT_COUNTER should be undefined
module dut
  #( parameter SAMPLE_SIZE = 24 )
   (
    input [4:0] bit_counter,
    output      data_done
    );
   generate
      case (SAMPLE_SIZE)
        16: begin : BIT_COUNTER
           localparam MAX  = 4'd15;
        end
        24: begin : BIT_COUNTER
           localparam MAX  = 5'd23;
        end
        32: begin : BIT_COUNTER
           localparam MAX  = 5'd31;
        end
      endcase // case (SAMPLE_SIZE)
   endgenerate

   assign data_done = (bit_counter >= BIT_COUNTER.MAX);
   initial begin
        $display("BIT_COUNTER.MAX = %0d", BIT_COUNTER.MAX);
   end

endmodule // dut