module dut(output int x);
   parameter int P [5];
   assign x = P[2];
endmodule

module top(output int o);
   dut #(.P('{1, 2, 3, 4, 5})) u_dut(.x(o));
endmodule