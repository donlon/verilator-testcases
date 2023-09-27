module t();

    wire x;
    wire a;

    logic b = 0;

    assign a = 1'b1;
    assign a = b;

    assign b = 1'b1;
    assign b = b;

endmodule