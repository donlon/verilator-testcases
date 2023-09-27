interface test_if (
    input a,
    output b
);
    assign b = !a;
endinterface : test_if

module test (
    input clk
);
    parameter INTF_COUNT = 4;

    logic [INTF_COUNT-1:0] sig_in = '0;
    logic [INTF_COUNT-1:0] sig_out;

    test_if intf[INTF_COUNT](.a(sig_in), .b(sig_out));

    int count = 0;

    logic [INTF_COUNT-1:0] sig_in_last;

    always_ff @(posedge clk) begin
        sig_in <= INTF_COUNT'($random());
        sig_in_last <= sig_in;
        if (count == 10) begin
            $write("*-* All Finished *-*\n");
            $finish;
        end else if (count > 0) begin
            if (sig_in_last != sig_out) $exit;
        end
        count <= count + 1;
    end

    logic [1:0] v[10];
    wire [1:0] q = v[2];
endmodule : test
//--dumpi-tree 9 --debug