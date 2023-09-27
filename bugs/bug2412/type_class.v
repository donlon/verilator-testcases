// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2023 by Anthony Donlon.
// SPDX-License-Identifier: CC0-1.0

typedef int type_0;
package pkg;
    typedef int mytype;

    class myclass;
        typedef int mytype;
    endclass
endpackage

//package mypkg;

class myclass;
    typedef int mytype;
    typedef int mytypea;
endclass

module t;
    parameter int type_0;
    //pkg::myclass::mytype a ;//= new;
    pkg::myclass a ;//= new;
    mypkg::subtype_t b = 10;
    mypkg::subtype_t c = 10;
    //notmodule m;
    mymodule module_name;
    typedef mypkg::subtype_t type_c;

    mymodule(
        input type_0
    );
    initial begin
        int mytype;
        int type_c;
    end

    //function
endmodule

module mymodule(
    input type_0
);

endmodule
