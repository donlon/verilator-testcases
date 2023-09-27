module test;

    localparam PARAM = 10;

    logic [15:0] a;
    logic [15:0] b;
    logic [15:0] z;

    if (PARAM == 10) begin : gen_sub1
        sub1 sub (
            .a,
            .b,
            .z
        );
    end else if (PARAM == 20) begin : gen_sub2
        sub2 sub (
            .a,
            .b,
            .z,
            .not_exist_pin
        );
    end

    // if (gen_sub1.sub.PARAM == 20) begin : gen_sub2_2
    //     sub2 sub (
    //         .a,
    //         .b,
    //         .z
    //     );
    // end

    if (PARAM == 30) begin : gen_sub3
        sub3_not_exist sub (
            .a,
            .b,
            .z
        );
    end

    initial begin
        #1;
        a = 2000;
        b = 1000;
        #1;
        if (z != 3000) begin
            $error("unexpected result, z = %0d", z);
            $stop;
        end
        #1;
        a = 5000;
        b = 3000;
        #1;
        if (z != 8000) begin
            $error("unexpected result, z = %0d", z);
            $stop;
        end
        $info("TEST PASS");
        $finish;
    end

endmodule : test

module sub1 (
    input [15:0] a,
    input [15:0] b,
    output [15:0] z
);
    localparam PARAM = 1;
    assign z = a + b;
endmodule : sub1

module sub2 (
    input [15:0] a,
    input [15:0] b,
    output [15:0] z
);
    localparam PARAM = 2;
    assign z = a - b;

    initial begin
        $error("FAILED");
        $stop;
    end
endmodule : sub2