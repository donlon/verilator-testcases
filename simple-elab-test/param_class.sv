class Cls #(int v = 10);
    function test();
        $display(v);
    endfunction
endclass

module t;
    //Cls #(10) cls_param10 = new;
    Cls #(20) cls_param20 = new;
    //Cls #() cls_param_def = new;
    //Cls cls_param_def2 = new;
endmodule