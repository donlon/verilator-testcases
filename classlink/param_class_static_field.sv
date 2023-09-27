class vector #(
    int size = 1
);
    bit [size-1:0] a;
    static int count = 0;
    function void disp_count();
        $display( "count: %0d, size %0d", count, size );
    endfunction
    function void inc_count();
        count++;
    endfunction
endclass

module t;
    vector v1 = new;
    vector #(2) v2 = new;
    vector #(3) v3 = new;

    initial begin
        v2.disp_count();
        v3.disp_count();

        v2.inc_count();
        v2.disp_count();
        v3.disp_count();

        v2.inc_count();
        v2.disp_count();
        v3.disp_count();

        v3.inc_count();
        v2.disp_count();
        v3.disp_count();

        v3.inc_count();
        v2.disp_count();
        v3.disp_count();

        v2.inc_count();
        v2.disp_count();
        v3.disp_count();
    end
endmodule