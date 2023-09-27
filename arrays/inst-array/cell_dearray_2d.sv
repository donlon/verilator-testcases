interface test_if #(
    parameter WIDTH = 1
) (
    input [WIDTH-1:0] in
);
endinterface : test_if

module test (
    input clk
);
    parameter INTF_COUNT = 4;
    parameter WIDTH = 3;

    logic [WIDTH-1:0] sig_in[INTF_COUNT];
    logic [WIDTH-1:0] sig_in_last[INTF_COUNT];
    logic [WIDTH-1:0] sig_out[INTF_COUNT];
    logic [WIDTH-1:0] sig_out_last[INTF_COUNT];
    // logic [WIDTH-1:0] [0:INTF_COUNT-1] sig_in/*[INTF_COUNT]*/;
    // logic [WIDTH-1:0] [0:INTF_COUNT-1] sig_in_last/*[INTF_COUNT]*/;
    // logic [WIDTH-1:0] [0:INTF_COUNT-1] sig_out/*[INTF_COUNT]*/;
    // logic [WIDTH-1:0] [0:INTF_COUNT-1] sig_out_last/*[INTF_COUNT]*/;

    test_if #(WIDTH) intf[INTF_COUNT](.in(sig_in));

    for (genvar i = 0; i < INTF_COUNT; i++) begin
        assign sig_out[i] = intf[i].in;
    end

    int count = 0;

    always @(posedge clk) begin
        foreach (sig_in[i]) begin
            sig_in[i] <= WIDTH'($random());
        end
        sig_in_last  <= sig_in;
        sig_out_last <= sig_out;
        if (count == 10) begin
            $write("*-* All Finished *-*\n");
            $finish;
        end else if (count > 0) begin
          if (sig_in_last != sig_out_last) begin
            $info("sig_in_last:  %p", sig_in_last);
            $info("sig_out_last: %p", sig_out_last);
            $stop;
          end
        end
        count <= count + 1;
    end

    logic [1:0] v[10];
    wire [1:0] q = v[2];
endmodule : test
//--dumpi-tree 9 --debug