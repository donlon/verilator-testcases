
package my_pkg;
    parameter int PARAM_1 = 5;
    parameter int PARAM_2 = 2**PARAM_1;

    typedef logic [7:0] my_type;

    localparam my_type PARAM_LOCAL = 8'hff;

    typedef my_type T_MAC_TABLE[PARAM_2];

    parameter int PARAM_3 = 2000;
    parameter int PARAM_4 = 10000;

    function logic [31:0] one_hot_to_binary(logic [63:0] one_hot, int size);
        for (int i = 0; i < size; i++) begin
            if (one_hot[i]) begin
                one_hot_to_binary = i;
                break;
            end
        end
    endfunction

    typedef enum int {
        ENUM_0,
        ENUM_1,
        ENUM_2
    } my_enum_t;

endpackage : my_pkg
