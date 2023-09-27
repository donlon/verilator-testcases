// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

module t;
    parameter type PARAM_TYPE = string;

    typedef string type_1_t;
    typedef PARAM_TYPE type_2_t;

  //string type_2_t = "str";

    initial begin
        automatic string type_2_t = "str";
        $display(type_2_t);
    end
endmodule