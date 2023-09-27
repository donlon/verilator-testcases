module t;
    parameter ADDR_SIZE = 10;
    initial begin
        assert (ADDR_SIZE >= 8) else $error("Must be 1024 KB minimum address size");
    end
    assert (ADDR_SIZE >= 8) else $error("Must be 1024 KB minimum address size");

endmodule
