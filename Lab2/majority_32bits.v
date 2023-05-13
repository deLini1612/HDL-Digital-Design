//---------------SPEC---------------
//  INPUT:  32 bits input
//  OUTPUT: 1 bit output
//  RELATION BETWEEN INPUT AND OUTPUT:
//        + If the input has at least 17 bit = 1, output = 1
//        + otherwise
//----------------------------------

module majority_32bits (
    input [31:0] in,
    output reg maj
);
    integer  i, count;
    always @(in) begin
        count = 0;
        for (i=0; i<32; i = i + 1)
            count = count + in[i];
        if (count >16) 
            maj = 1;
        else maj = 0;
    end

endmodule