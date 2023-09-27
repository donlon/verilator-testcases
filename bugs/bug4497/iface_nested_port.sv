interface intf1 (
	input clk,
	intf2 intf,
	output out2
);
	
endinterface : intf1

interface intf2 (
	input clk,
	input in,
	output out
);
	
endinterface : intf2

module t;
	logic clk;
	logic a;
	logic b;
	logic c;
	intf2 intf2 (.clk, .in(a), .out(b));
	intf1 intf1 (.clk, .intf(intf2), .out2(c));
endmodule
