interface bar #(
  parameter int unsigned param
) ();
  typedef struct {
    logic valid;
    logic [param-1:0] data;
  } struct_t;
endinterface

module foo #() (
  input logic                 i_clk,
  input logic                 i_rst,
  bar bar_if
);
  typedef bar_if.struct_t struct_t;
endmodule