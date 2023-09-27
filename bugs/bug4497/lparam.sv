parameter A = 10;

module t (
  input clk  
);

  begin
    int v;
  end

  begin : blk_1
    int v;
  end

  if (1 == 1) int v;

  if (1 == 1) begin
    int v;
  end

  if (1 == 1) begin
    int v;
  end else begin : blk2
    for(genvar i=0;i<1;i++)begin
      int v;
      begin : blk
        
      end
    end
  end

  case (1)
    1: $error("1");
    2: begin
      begin
      end
    end
  endcase

  for(genvar i=0;i<1;i++)begin
    int v;
    begin : blk
      
    end
  end

  generate
    if(1) int v;
  endgenerate

endmodule : t