// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

// Test for bug4281

class CParam #(parameter PARAM=10);
    typedef int type_t;
endclass

typedef CParam::type_t cls_t;
typedef CParam#(10)::type_t cls10_t;
typedef CParam#(20)::type_t cls20_t;

typedef CParam cls_cls_t;
typedef CParam#(10) cls10_cls_t;
typedef CParam#(20) cls20_cls_t;

module t;
    CParam::type_t val = 100;
    CParam#(10)::type_t val_10 = 100;
    CParam#(20)::type_t val_20 = 100;

    CParam cls;
    CParam#(10) cls_10;
    CParam#(20) cls_20;

    initial begin
        //if (val_0 != 100) $stop;
        //if (val_2 != 200) $stop;
        //$write("*-* All Finished *-*\n");
        //$finish;
    end
endmodule
