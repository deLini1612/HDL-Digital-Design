// Implementation BCD to 7seg decoder
// In DE2-70 Board has 8 7-seg COMMON ANODE displays (logic 0 is light)

module display (
    input [4:0] one_hot,
    output reg [6:0] seg
);
    always @(one_hot) begin
        case(one_hot)
            1:seg = 7'b1001111;
            2:seg = 7'b0010010;
            4:seg = 7'b0000110;
            8:seg = 7'b1001100;
            16:seg = 7'b0100100;
            default: seg = 7'b1111111;
        endcase
    end
endmodule