interface test_if ();
    logic a;
    logic b;
    assign b = !a;
endinterface : test_if

module test (
    input clk
);
    parameter INTF_COUNT = 4;

    logic [INTF_COUNT-1:0] sig_in = '0;
    logic [INTF_COUNT-1:0] sig_out;

    test_if intf[$clog2(2 ** INTF_COUNT)]();

    for (genvar i = 0; i < INTF_COUNT; i++) begin
        assign intf[i].a = sig_in[i];
        assign sig_out[i] = intf[i].b;
    end

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

endmodule : test