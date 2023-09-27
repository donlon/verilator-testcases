package pf;
   typedef struct packed {
      int unsigned CcNumTl;
      int unsigned PqSize;
   } cfg_t;
endpackage

virtual class xxx_class #(parameter pf::cfg_t Cfg);
   typedef struct packed {
      logic [$clog2(Cfg.CcNumTl)-1:0] tl_index;
      logic [$clog2(Cfg.PqSize)-1:0] pq_index;
   } cmd_tag_t;
endclass

module mod2  #(parameter p_width=16) (
   output logic [p_width-1:0] q,
   input logic [p_width-1:0] d
);
   assign q = d;
endmodule

module top();
   localparam pf::cfg_t Cfg0 = '{
      CcNumTl:8,
      PqSize:12
   };

   xxx_class#(Cfg0)::cmd_tag_t tag, tag_q;

   //bit [31:0] tag, tag_q;

   mod2 #($bits(tag)) t0(tag_q, tag);

    //$bits(xxx_class#(Cfg0)::cmd_tag_t): resolved in Width -- after V3Param
   initial begin
      //#100;
      $finish;
   end
endmodule