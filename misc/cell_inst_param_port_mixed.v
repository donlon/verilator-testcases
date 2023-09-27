// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

module sub # (
    parameter PARAM_A = 1,
    localparam PARAM_C = 1,
    parameter type PARAM_B = logic
) (
    input pin_1
);

    typedef string my_type_t;

    PARAM_B myvar = "mystr";
    //initial $display("%p", PARAM_B);
    initial $display(myvar);
endmodule

module t;
    parameter int PARAM_A = 10;
    parameter type PARAM_B = string;
    //parameter type PARAM_B = 2;
    //parameter int PARAM_B = 2;
    //parameter type PARAM_B = int;

    sub #(
        .PARAM_B(PARAM_B)
        //.pin_1(1)
        //.PARAM_C(10)
    ) i_sub (
        //.PARAM_B(PARAM_B)
        //.PARAM_A(1)
        //.PARAM_B(PARAM_B)
        //.PARAM_B(PARAM_B)
        //.PARAM_B(int),
        //.PARAM_B(PARAM_B),
    );
endmodule