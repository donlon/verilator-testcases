interface intf #(A=0);  // `A=1` ok
        typedef logic logic_t;

        function logic_t f();  // logic_t => `logic` ok
                return 0;
        endfunction

        modport if_m (
                import f
        );
endinterface

module system;
        //intf #(0) intf1();  // `1` => `0` ok.
        intf #(1) intf1();  // fail
        m m0(.*);
endmodule

module m (intf.if_m intf1);
        //using `initial` ok
        if (intf1.f())  // `if(0)` ok
                $error();
endmodule