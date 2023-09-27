module t(
    clk
);
    input clk;

    logic [4:0] in = 0;
    logic [10:0] in2 = 0;

    wire [31:0][38:0] testvar = {32{39'd114514}};

    always @(posedge clk) begin
        //$display("#1, result=%d", testvar[in + 5'b1]);
        $display("#2, result=%d", testvar[in]);
        $display("#3, result=%d", testvar[in2]);
        $display("#4, result=%d", testvar[12]);
        if (in == 5'd31) $finish;
    end

    always @(posedge clk) begin
        in++;
    end

endmodule
