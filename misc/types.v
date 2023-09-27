// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

module t;
    parameter type PARAM_B = string;

    sub #(
        .PARAM_TYPE(PARAM_B)
    ) i_sub (
    );

    PARAM_B str;

  	// Questa: ** Error: testbench.sv(26): 'sub' is an unknown type.
  	// VCS:   Following verilog source has syntax error : port type is not an interface or user-defined type
  // xmvlog: *E,NOIPRT (testbench.sv,29|22): Unrecognized declaration 'str2' could be an unsupported keyword, a spelling mistake or missing instance port list '()' [SystemVerilog].
    //sub.PARAM_TYPE str2;

  // Questa: 'i_sub' is an unknown type.
  // VCS: Identifier not in port list : Identifier 'str3' does not appear in port list. (?)
  //i_sub.type_1_t str3;
  //i_sub.type_2_t str4;

endmodule

module sub # (
    parameter type PARAM_TYPE = logic
) (
    //input pin_1
);

    typedef string type_1_t;
    typedef PARAM_TYPE type_2_t;

  type_1_t mystr;
  type_2_t mystr2;
  initial begin
    type_2_t PARAM_TYPE;
  end
endmodule
