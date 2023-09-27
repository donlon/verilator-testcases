`timescale 1ns/1ps

interface intf_if;
    logic [W-1:0] a;
endinterface

module t;
    mod_generator i_generator ();
endmodule

module mod_generator (
	intf_if intf
);
    logic [$bits(intf)-1:0] x;
endmodule : mod_generator

/*
%Warning-PINMISSING: simple_elab_intf_conn_bad.sv:8:19: Cell has missing pin: 'intf'
    8 |     mod_generator i_generator (
      |                   ^~~~~~~~~~~
                     ... For warning description see https://verilator.org/warn/PINMISSING?v=5.014
                     ... Use "/* verilator lint_off PINMISSING */" and lint_on around source to disable this message.
%Error: simple_elab_intf_conn_bad.sv:13:2: Parent instance's interface is not found: 'intf_if'
   13 |  intf_if intf
      |  ^~~~~~~
%Error: Internal Error: simple_elab_intf_conn_bad.sv:3:11: ../V3LinkDot.cpp:414: Module/etc never assigned a symbol entry?
    3 | interface intf_if;
      |           ^~~~~~~
*/