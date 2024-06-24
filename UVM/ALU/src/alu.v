module alu (
    input clk,
    input rst,
    input [7:0] A,
    input [7:0] B,
    input [1:0] op,
    output reg [7:0] out,
    output reg carry_out
);

reg [8:0] buf_out;

always @(op, A, B) begin
    case(op)
    0: //ADD
        buf_out = A+B;

    1: //SUB
        buf_out = A-B;

    2: //BITWISE AND
        buf_out = {1'b0, A&B};

    3: //BITWISE OR
        buf_out = {1'b0, A|B};
    endcase
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        out <= 0;
        carry_out <= 0;
    end
    else begin
        out <= buf_out[7:0];
        carry_out <= buf_out[8];
    end
end
endmodule: alu