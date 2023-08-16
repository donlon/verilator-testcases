package common_pkg;
    class onehot_selector #(
        parameter int N = 4,
        parameter int DWIDTH = 32
    );
        static function automatic logic [DWIDTH-1:0] select(input logic [N-1:0] sel, logic [DWIDTH-1:0] in[N]);
            logic [DWIDTH-1:0] out = '0;
            for (int i = 0; i < N ; i++) begin
                out |= sel[i] ? in[i] : '0;
            end
            return out;
        endfunction : select

        static function automatic logic [$clog2(N)-1:0] encode(input logic [N-1:0] sel);
            logic [$clog2(N)-1:0] out = '0;
            for (int i = 0; i < N ; i++) begin
                out |= sel[i] ? i[$clog2(N)-1:0] : '0;
            end
            return out;
        endfunction : encode
    endclass : onehot_selector
endpackage : common_pkg
