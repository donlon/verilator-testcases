package OpPkg;
  typedef enum logic [2:0] {
    A = 3'b000,
    B = 3'b10?,
    C = 3'b11?
  } MiscOpcode_e;

endpackage

module top();
    logic [2:0] stash;
    logic [1:0] Opcode;

    always_comb
    casez(stash)
      OpPkg::A: Opcode = 2'b11;
      OpPkg::B: Opcode = 2'b10;
      OpPkg::C: Opcode = 2'b00;
      default:  Opcode = 'x;
    endcase

  initial begin
    stash = 3'b101;
    $display("%0x", Opcode);
  end
endmodule