`timescale 1ns/1ps

interface intf_if # (
    parameter int W = 16
) (
    input clk
);

    logic [W-1:0] a;
    logic [$clog2($bits(a))-1:0] b;

    modport gen (a, b);
    modport mon (a, b);
endinterface

module simple_elab (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	output out
);
    function int clog2(logic [127:0] value);
        if (value == 0) return 0;
        value = value - 1;
        for (int i = 0; i < $bits(value); i++) begin
            if (value == 0) return i;
            value = value >> 1;
        end
    endfunction : clog2

    logic [$clog2(10)-1:0] simple_pin0;
    logic [$bits(simple_pin0)-1:0] simple_pin1;

    typedef logic [$clog2(4)-1:0] newtype_t;

	intf_if intf[($clog2(4) - 1) * 2 ** 2](.clk); // 4
	intf_if #(10)intf_param[($clog2(4) - 1) * 2 ** 2](.clk); // 4

	intf_if #(4) intf_2(.clk);
	intf_if #(8) intf_3(.clk);

    //parameter INTF_PARAM_0 = intf[1].W;
    //parameter INTF_PARAM_1 = intf_param[2].W;

	localparam int PORT_COUNT = 6;
	localparam int NEW_PARAM = clog2(16) + PORT_COUNT - $bits(clk) * 4 - $clog2(2 + $bits(simple_pin1) - 3); // 4
	localparam int NEW_PARAM_UNUSED = clog2(16) + PORT_COUNT - $bits(clk) * 4 - $clog2(2 + $bits(simple_pin1) - 3); // 4

	logic [PORT_COUNT-1:0] out_int;

	intf_conn i_conn(
		.intf(intf_3),
		.intf_gen(intf_2),
		.intf_mon(intf_2)
	);

	intf_conn_arr #(4) i_conn_arr(
		.intf(intf),
		.intf_gen(intf),
		.intf_mon(intf_param)
	);

    mod_generator # (
        .PORT_ID((1000 + 1000) / 2),
        .OUT_WIDTH(NEW_PARAM)
    ) i_generator (
        .clk,    // Clock
        .rst,  // Asynchronous reset active low
        .intf(intf_2.gen),
        .out0(),
        .out()
    );

    if ($clog2(16) == 3) begin
        mod_monitor # (
            .PORT_ID((1000 + 1000) / 2),
            .IN_WIDTH(NEW_PARAM)
        ) i_should_not_inst_this (
            .clk,    // Clock
            .rst,  // Asynchronous reset active low
            .intf(intf[0]),
            .in0(),
            .in(),
            .res()
        );
    end

	for (genvar i = 0; i < $bits(out_int); i++) begin : gen_generators
		logic data0_int;
		logic [3:0] data_int;

		mod_generator # (
			.PORT_ID(i),
			.OUT_WIDTH(4)
		) i_generator (
			.clk,    // Clock
			.rst,  // Asynchronous reset active low
        .intf(intf[0]),
			
			.out0(data0_int),
			.out(data_int)
		);

		mod_monitor # (
			.PORT_ID(i),
			.IN_WIDTH(4)
		) i_monitor (
			.clk,    // Clock
			.rst,  // Asynchronous reset active low
			
        .intf(intf[0]),
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

	intf_if intf,

	output logic out0,
	output logic [OUT_WIDTH-1:0] out
);

    logic [$bits(intf.a)-1:0] x;
	
	initial begin
		out = 0;
	end

	always_ff @(posedge clk or posedge rst) begin
		if(rst) begin
			out0 <= 1'(PORT_ID % 2);
			out <= OUT_WIDTH'(PORT_ID);
		end else begin
			out0 <= | out;
			out <= out + 1;
		end
	end
    intf_if intf_inner(.clk(rst));

endmodule : mod_generator

module mod_monitor # (
	parameter PORT_ID = 0,
	parameter IN_WIDTH = 4
) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low

	intf_if intf,
	
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

    intf_conn i_multi_level_conn (
        .intf(intf),
        .intf_gen(intf),
        .intf_mon(intf)
    );

    intf_if intf_inner(.clk(rst));
endmodule : mod_monitor

module intf_conn (
	intf_if intf,
	intf_if.gen intf_gen,
	intf_if.mon intf_mon
);

endmodule : intf_conn

module intf_conn_arr #(
	parameter N = 10
) (
	intf_if intf[N],
	intf_if.gen intf_gen[N],
	intf_if.mon intf_mon[N]
);

endmodule : intf_conn_arr
