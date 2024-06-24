interface alu_interface(
    input logic clk
);

    logic rst;
    logic [7:0] A;
    logic [7:0] B;
    logic [1:0] op;
    logic [7:0] out;
    bit carry_out;
    
endinterface: alu_interface