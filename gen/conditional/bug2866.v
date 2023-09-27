module a;
localparam A=1;
generate
if (A==0)
begin
b b_inst(.x(1'b0));
end
endgenerate
endmodule

module b;
endmodule