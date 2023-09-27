module t(
    clk
);
    input clk;

    logic [7:0] lhs = 8'd100;

    wire [15:0] mul1 = lhs * 5'd10;
    wire [15:0] mul2 = lhs * 11'd10;
    wire [15:0] mul3 = lhs * 10;

    wire [15:0] mul4 = 37 * 5'd10;
    wire [15:0] mul5 = 37 * 11'd10;
    wire [15:0] mul6 = 37 * 10;

    wire [15:0] add1 = 16'(lhs + 5'd10);
    wire [15:0] add2 = 16'(lhs + 11'd10);
    wire [15:0] add3 = 16'(lhs + 10);

    wire [15:0] add4 = 16'(37 + 5'd10);
    wire [15:0] add5 = 16'(37 + 11'd10);
    wire [15:0] add6 = 16'(37 + 10);

    always @(posedge clk) begin
        $display("#2, result=%d", lhs * 5'd10);
        $display("#2, result=%d", lhs * 11'd10);
        $display("#3, result=%d", lhs * 10);
        $display("#2, result=%d", lhs + 5'd10);
        $display("#2, result=%d", lhs + 11'd10);
        $display("#3, result=%d", lhs + 10);
    end

endmodule
