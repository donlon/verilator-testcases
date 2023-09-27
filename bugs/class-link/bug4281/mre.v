package Pkg;
    class CInPkg;
        typedef struct packed {
            int a;
            //logic [AW-1:0] addr;
        } a_ch_t;
    endclass
endpackage : Pkg

class CNoParam;
    typedef struct packed {
        int a;
        //logic [AW-1:0] addr;
    } a_ch_t;
endclass

class CParam #(parameter AW=32);
    typedef struct packed {
        int a;
        //logic [AW-1:0] addr;
    } a_ch_t;
endclass

module t;

    // class CNoParam;
    //     typedef struct packed {
    //         int a;
    //         //logic [AW-1:0] addr;
    //     } a_ch_t_in_class;
    // endclass

    typedef struct packed {
        int a;
        //logic [AW-1:0] addr;
    } normal_struct;

    normal_struct str;

    //C #(32)::a_ch_t a_channel; // OK
    // Pkg::CInPkg::a_ch_t var1; // Unsupported

    typedef CNoParam::a_ch_t a_ch_t_typedef;
    //      ^ REFDTYPE.CLASSORPACKAGEREF

    // CNoParam::a_ch_t var2a;
    // CNoParam::a_ch_t var2b;
    // a_ch_t_typedef var2c;
    // //CParam#(32)::a_ch_t var3; // OK
    // CParam::a_ch_t var3; // FAIL
    //CParam#(100)::a_ch_t var4; // FAIL
    //      ^ (TYPE-IDENTIFIER)
    // 2: VAR 000001F39EE237D0 <e599#> {d10ap} @dt=0000000000000000@  a_channel VAR
    //   1: REFDTYPE 000001F39EE422B0 <e600#> {d10ai} @dt=0000000000000000@  a_ch_t -> UNLINKED
    //     2: CLASSORPACKAGEREF 000001F39EE27430 <e598#> {d10af} @dt=0000000000000000@  C cpkg=000001F39EE28C30 -> CLASS 000001F39EE28C30 <e569#> {d1ab}  C  L4 [NONE]

endmodule