`timescale 1ns/1ps

module simple_elab (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	output out
);

	localparam int PORT_COUNT = 6;
	
	logic [PORT_COUNT-1:0] out_int;

	for (genvar i = 0; i < PORT_COUNT; i++) begin : gen_generators
		logic data0_int;
		logic [7:0] data_int;

		mod_generator # (
			.PORT_ID(i),
			.OUT_WIDTH(4)
		) i_generator (
			.clk,    // Clock
			.rst,  // Asynchronous reset active low
			
			.out0(data0_int),
			.out(data_int)
		);

		mod_monitor # (
			.PORT_ID(i),
			.IN_WIDTH(4)
		) i_monitor (
			.clk,    // Clock
			.rst,  // Asynchronous reset active low
			
			.in0({data0_int}),
			.in({data_int}),  // Asynchronous reset active low

			.res(out_int[i])
		);
	end

	assign out = ^ out_int | gen_generators[0].i_generator.out0;

endmodule : simple_elab

module mod_generator # (
	parameter PORT_ID = 0,
	parameter OUT_WIDTH = 4
) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	
	output logic out0,
	output logic [OUT_WIDTH-1:0] out
);
	
	initial begin
		out = 0;
	end

	always_ff @(posedge clk or posedge rst) begin
		if(rst) begin
			out0 <= PORT_ID % 2;
			out <= PORT_ID;
		end else begin
			out0 <= | out;
			out <= out + 1;
		end
	end

endmodule : mod_generator

module mod_monitor # (
	parameter PORT_ID = 0,
	parameter IN_WIDTH = 4
) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	
	input logic in0,
	input logic [IN_WIDTH-1:0] in,  // Asynchronous reset active low

	output logic res
);
	
	initial begin
		res = 0;
	end

	always_ff @(posedge clk or posedge rst) begin
		if(rst) begin
			res <= 1;
		end else begin
			res <= in0 ^ (^ in);
		end
	end

endmodule : mod_monitor