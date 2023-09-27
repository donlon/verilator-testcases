module ALU(
  input         clock,
  input  [4:0]  operation,
  input  [63:0] inputs_1,
                inputs_0,
                inputs_2,
  input  [16:0] immediate,
  output [63:0] output_0
);
  reg  [63:0]  casez_tmp_1;
  always_comb begin
    automatic logic [63:0] lowHigh;
    casez (operation)
      5'b00011:
        casez_tmp_1 = inputs_0 & inputs_1;
      5'b00100:
        casez_tmp_1 = inputs_0 | inputs_1;
      5'b00101:
        casez_tmp_1 = inputs_0 ^ inputs_1;
      5'b01001: begin
        automatic logic [16:0] _aluOutput_T_22 =
          immediate >> {14'h0, inputs_2, inputs_1[0], inputs_0[0]};
        casez_tmp_1 = {63'h0, _aluOutput_T_22[0]};
      end
      default:
        casez_tmp_1 = inputs_0;
    endcase
  end
endmodule