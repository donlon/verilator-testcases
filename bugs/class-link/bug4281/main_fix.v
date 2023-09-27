package param_pkg;

   localparam int AW=37;
   localparam int DW=256;
   localparam int MW=DW/8;

endpackage

package pkg;

class C #(parameter AW=param_pkg::AW);
  typedef enum logic [2:0] {
    Put            = 3'h 0,
    Get            = 3'h 4
  } a_op_t;

  typedef enum logic [2:0] {
    AccessAck      = 3'h 0,
    AccessAckData  = 3'h 1
  } d_op_t;

  typedef struct packed {
    logic                        valid;
    a_op_t                       opcode;
    logic  [param_pkg::AW-1:0]   address;
    logic  [param_pkg::MW-1:0]   mask;
    logic  [param_pkg::DW-1:0]   data;
  } a_ch_t;

  typedef struct packed {
    logic                        valid;
    d_op_t                       opcode;
    logic  [param_pkg::AW-1:0]   address;
    logic  [param_pkg::MW-1:0]   mask;
    logic  [param_pkg::DW-1:0]   data;
  } d_ch_t;

endclass

endpackage

import param_pkg::*;
import pkg::*;

module adapter_mem
  #(
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = 32
    )
  (
   input                           clk,
   input                           reset_l,

   output logic                    a_ready,
   input  C#()::a_ch_t                a_channel,
   input  logic                    d_ready,
   output C#()::d_ch_t                d_channel,

   output logic [ADDR_WIDTH-1:0]   addr,
   output logic                    w_en,
   output logic [DATA_WIDTH-1:0]   w_data,
   output logic [DATA_WIDTH/8-1:0] w_mask,
   output logic                    r_en,
   input  logic [DATA_WIDTH-1:0]   r_data
   );

   logic                  a_fire = a_ready && a_channel.valid;
   logic 		  a_read = a_channel.opcode == C#()::Get;
   logic 		  r_full;
   logic 		  r_read;
   logic 		  r_en_reg;
   logic [DATA_WIDTH-1:0] r_data_reg;

   assign addr   = a_channel.address;
   assign w_en   = a_fire && !a_read;
   assign w_mask = a_channel.mask;
   assign w_data = a_channel.data;
   assign r_en   = a_fire && a_read;

   assign a_ready = ~r_full | d_ready;

   assign d_channel.valid  = r_full;
   assign d_channel.opcode = r_read ? C#()::d_op_t'(C#()::AccessAckData) : C#()::d_op_t'(C#()::AccessAck);
   assign d_channel.data   = r_en_reg ? r_data : r_data_reg;

   always_ff @(posedge clk) begin
      if (a_fire) begin
	 r_read   <= a_read;
      end
      r_en_reg <= r_en;
      if (r_en_reg) begin
	 r_data_reg <= r_data;
      end
   end

   always @(posedge clk or negedge reset_l) begin
      if (!reset_l) begin
	 r_full <= 1'h0;
      end else begin
	 r_full <= a_fire ||
		   (d_ready ? 1'h0 : r_full);
      end
   end

endmodule

module testmem #(
   parameter DATA_WIDTH=64,
   parameter ADDR_WIDTH=32
) (
   input logic 			  clk,
   input logic [ADDR_WIDTH-1:0]   addr,
   input logic 			  w_en,
   input logic [DATA_WIDTH-1:0]   w_data,
   input logic [DATA_WIDTH/8-1:0] w_mask,
   input logic 			  r_en,
   output logic [DATA_WIDTH-1:0]  r_data
   );

   logic [DATA_WIDTH-1:0] mem [logic [ADDR_WIDTH-1:0]];
   logic [ADDR_WIDTH-1:0] addr_reg;

   always @(posedge clk)
     if (r_en) addr_reg <= addr;

   assign r_data = mem[addr_reg];

   generate
      genvar i;
      for (i = 0; i < DATA_WIDTH/8; i = i + 1)
	always @(posedge clk)
	  if (w_en && w_mask[i])
	    mem[addr][i*8+7:i*8] <= w_data[i*8+7:i*8];
   endgenerate

endmodule // testmem

module t (/*AUTOARG*/
   // Inputs
   clk, reset_l
   );

   input     clk;
   input     reset_l;

   logic     a_ready;
   C#()::a_ch_t a_channel;
   logic     d_ready;
   C#()::d_ch_t d_channel;

   logic [AW-1:0]   addr;
   logic 	    w_en;
   logic [DW-1:0]   w_data;
   logic [DW/8-1:0] w_mask;
   logic 	    r_en;
   logic [DW-1:0]   r_data;

   adapter_mem #(.DATA_WIDTH(DW), .ADDR_WIDTH(AW)) adapter_mem( .* );

   testmem #(.DATA_WIDTH(DW), .ADDR_WIDTH(AW)) testmem( .* );

   initial begin
      if ($bits(a_channel.address) != AW) $stop;
      if ($bits(a_channel.data) != DW) $stop;

      a_channel.valid = 1'b0;
  end

   always @ (posedge clk) begin
      if (reset_l) begin
	 a_channel.valid   = 1'b1;
	 a_channel.opcode  = C#()::Put;
	 a_channel.address = 16;

	 $write("*-* All Finished *-*\n");
	 $finish;
      end
   end

endmodule