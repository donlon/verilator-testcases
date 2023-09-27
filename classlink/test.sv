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

module top (
    input                                           clk,
    input                                           rst
);

    logic [3:0] sel;
    logic [7:0] arr[4];

    logic [1:0] o1;
    logic [7:0] o2;
    logic [7:0] o3;

    always_ff @(posedge clk) begin
        o1 <= common_pkg::onehot_selector#(.N(4))::encode(sel);
        //o2 <= common_pkg::onehot_selector#(.N(4)/*, .DWIDTH(8)*/)::select(sel, arr);
        o3 <= common_pkg::onehot_selector#(.N(4), .DWIDTH(8))::select(sel, arr);
    end

    initial begin
        sel = 0;
        arr = '{default: '0};
    end

endmodule : top




class Bar;
   parameter type T = int;
   T t;
   function new;
      t = new;
   endfunction
endclass

class Baz;
   int x = 1;
endclass

module t (/*AUTOARG*/);
   initial begin
      Bar#(Baz) bar_baz = new;
      if (bar_baz.t.x != 1) $stop;

      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule