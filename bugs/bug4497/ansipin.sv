module t;
    mod1 # () i_mod1 (.pin_1(1));
endmodule

module mod1 # (
    parameter A = 0
)(pin_1);

if (A==0) $error("");
    input pin_1;
endmodule
