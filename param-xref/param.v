//interface simple_bus #(PARAMETER = 0);
//   parameter [6:0] dummy = 22;
//endinterface

module sub # (
    parameter NUM = 0
) (
);

endmodule

module t ();
    sub i_sub();
    sub #(2)i_sub2();
    sub #(4)i_sub4();
endmodule
