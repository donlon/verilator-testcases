module t();
  /*
  for (genvar i = 0; 1 == 1; i++) begin
    initial begin end
  end
*/
  int a = 0;
  initial begin
        for (int v=0;2==2;v++) begin // Infinite loop (condition always true)
                a++;

                //if (a == 10) break;
                if (a == 100) $exit;
        end
  end
endmodule