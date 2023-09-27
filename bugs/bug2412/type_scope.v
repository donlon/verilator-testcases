// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

module t;
    //parameter type PARAM_TYPE = string;

    typedef string type_1_t;

    sub i_sub();

    initial begin
        typedef string type_2_t;
        //int type_1_t = 100;
        //int type_2_t = 100; // 'type_2_t' already declared as a typedef
        //automatic string type_2_t = "str";
        //$display(type_2_t);
    end

    //i_sub.sub_type_t myval = "str"; // VCS/Questa: unsupported
    //typedef i_sub.sub_type_t newtype;
    //newtype myval;// = "str";


    int type_2_t; // bad
endmodule

module sub;
    typedef string sub_type_t;
    int type_1_t = 100;

    initial begin
        $display(type_1_t);
    end
endmodule