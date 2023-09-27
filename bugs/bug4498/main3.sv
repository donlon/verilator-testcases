module t(clock, in);
  input clock;
  input [4:0] in;
  wire [1203:0][38:0] testvar = {1024{39'd114514}};
  always @(posedge clock) begin
    $display("in=%d, result=%d", in, testvar[in + 5'b1]);
    if (in == 5'd31) $finish;
  end
endmodule