module t;
logic var_name1;
    typedef enum {
        s3
    } state_t;
   S s1 ();
   S var_name ();
endmodule // CPU

// Sequences operations in a state machine
module S ();
//logic var_name;
    typedef enum {
        s0,
        s1,
        s2,
        s3
    } state_t;
    //enum {s0, s1} state;
    logic var_name; // ok
    logic var_name1; // ok

    initial begin
        $write("*-* All Finished *-*\n");
        $finish;
    end
endmodule // s