// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

// Test for bug4281

class CParam #(parameter PARAM=10);
    typedef int type_t;

    function void check_param(int val);
        if (val != PARAM) $stop;
    endfunction
endclass

module t;
    CParam::type_t val = 100;
    CParam cls = new;

`ifdef CONSTSIM
    parameter N = 32;
    for (genvar i = 0; i < N/8; i = i + 1) begin
        initial begin
        end
    end
`endif

    initial begin
        if (val != 100) $stop;
        cls.check_param(10);
        $write("*-* All Finished *-*\n");
        $finish;
    end
endmodule