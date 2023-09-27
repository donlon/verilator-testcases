module  sub2 (
  input  clk, rst,
  input  d,
  output stat,
  output reg q
);

assign  stat = ~q;

always @(posedge clk)
if (rst)
    q<=0;
else
    q<=d;
  
endmodule

module  sub1 (
  input  d,
  output q
);

wire clk, rst, stat;

sub2 sub2(.d(d), .q(q), .stat(stat), .clk(clk), .rst(rst) );
  
endmodule

module  top (
  input  clk, rst,
  input  d,
  output q, stat
);

sub1 sub1(.d(d), .q(q));

assign  sub1.clk = clk;
assign  sub1.rst = rst;
assign  stat = sub1.stat;
  
endmodule
