package OpPkg;
  typedef enum logic [2:0] {
    MISC0 = 3'b000,
    MISC0x = 3'b00?,
    MISC1x = 3'b10?
  } MiscOpcode_e;

endpackage

module top();
    logic [2:0] stash;
    logic [1:0] Opcode;

    always_comb
    unique casez(stash) inside
      OpPkg::MISC0: Opcode = 2'b11;
      OpPkg::MISC0x: Opcode = 2'b10;
      OpPkg::MISC1x: Opcode = 2'b00;
      default:      Opcode = 'x;
    endcase

  initial begin
    stash = 3'b101;
    $display("%0x", Opcode);
  end
endmodule