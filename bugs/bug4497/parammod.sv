module t;
    mod1 # (
        3, 4, 5
        //, 0
    ) i_mod1 ();
    mod1 # (
        .A(3),
        .B(4),
        .C(5)
        ,.F(5)
        //, .E(0)
    ) i_mod11 ();

    mod2 # (
        3, 4, 5,
        200
    ) i_mod2 ();

    mod3 # (
        3, 4, 5,
        200
    ) i_mod3 ();

    modx modx();
endmodule

module modx;
    if (1==1) begin
        parameter v = 0;
    end
endmodule

module mod1 # (
    parameter A = 0,
    parameter B = 0,
    parameter C = 0,
    localparam F = 0
);
    localparam E = 100;
    parameter D = 100;
    //parameter E = 0;

    if (A**2 + B**2 != C**2) $error("A**2 + B**2 != C**2");
    if (D != 100) $error("D != 100");
endmodule

module mod2 ();
    parameter A = 0;
    parameter B = 0;
    parameter C = 0;

    parameter D = 100;
    parameter E = 0;

    if (A**2 + B**2 != C**2) $error("A**2 + B**2 != C**2");
    if (D != 200) $error("D != 200");
endmodule

module mod3 #() ();
    parameter A = 0;
    parameter B = 0;
    parameter C = 0;

    parameter D = 100;
    parameter E = 0;

    if (A**2 + B**2 != C**2) $error("A**2 + B**2 != C**2");
    if (D != 200) $error("D != 200");
endmodule

interface intf1 # (
    parameter A = 0,
    parameter B = 0,
    parameter C = 0
);
    localparam E = 100;
    parameter D = 100;
    //parameter E = 0;

    if (A**2 + B**2 != C**2) $error("A**2 + B**2 != C**2");
    if (D != 100) $error("D != 100");
endinterface

interface intf2 ();
    parameter A = 0;
    parameter B = 0;
    parameter C = 0;

    parameter D = 100;
    parameter E = 0;

    if (A**2 + B**2 != C**2) $error("A**2 + B**2 != C**2");
    if (D != 200) $error("D != 200");
endinterface

interface intf3 #() ();
    parameter A = 0;
    parameter B = 0;
    parameter C = 0;

    parameter D = 100;
    parameter E = 0;

    if (A**2 + B**2 != C**2) $error("A**2 + B**2 != C**2");
    if (D != 200) $error("D != 200");
endinterface