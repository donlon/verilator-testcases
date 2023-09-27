class cls #(parameter int A = 0);
  cls#(A+1) c;
endclass

module t;
  cls#(1) a = new;
endmodule;