package OpPkg;
  typedef enum logic [2:0] {
    MISC0 = 3'b000,
    MISC1 = 3'b001,
    MISC2 = 3'b010,
    MISC3 = 3'b011,
    MISC4 = 3'b100,
    MISC5 = 3'b101,
    MISC6 = 3'b110,
    MISC0x = 3'b00?,
    MISC1x = 3'b10?
  } MiscOpcode_e;

  typedef enum logic [6:0] {
  OP08   = 7'h08,
  OP09   = 7'h09,
  OP60   = 7'h60,
  OP61   = 7'h61,
  OP62   = 7'h62,
  OP66   = 7'h66,
  OP67   = 7'h67
} Opcode_e;
endpackage

module top();
  begin
    OpPkg::MiscOpcode_e stash;
    OpPkg::Opcode_e Opcode;

    always_comb
    unique case(stash) inside
      OpPkg::MISC0: Opcode = OpPkg::OP61;
      OpPkg::MISC1: Opcode = OpPkg::OP60;
      OpPkg::MISC2: Opcode = OpPkg::OP09;
      OpPkg::MISC3: Opcode = OpPkg::OP08;
      OpPkg::MISC4: Opcode = OpPkg::OP66;
      OpPkg::MISC5: Opcode = OpPkg::OP67;
      OpPkg::MISC6: Opcode = OpPkg::OP62;
      default:      Opcode = OpPkg::Opcode_e'('x);
    endcase
  end
endmodule
