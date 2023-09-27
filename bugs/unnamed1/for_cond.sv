// Code your testbench here
// or browse Examples
module t();
  for (genvar i = 10; i; i--) begin // Logical operator GENFOR expects 1 bit on the For Test Condition, but For Test Condition's VARREF 'i' generates 32 bits.
    initial begin $display(i);end
  end
endmodule