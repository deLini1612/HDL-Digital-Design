//---------------SPEC---------------
//  INPUT:  16 bits
//          Devided to 4 group
//          Each group encoding for binary number 0-15
//  OUTPUT: 28 bits
//          Devided to 4 group
//          Each group controls 1 7-segment LED
//----------------------------------

module BCD27seg (
    input [3:0]bcd,
    output [6:0]seg
);

    assign seg = (bcd==0) ? 7'b0000001:
        (bcd==1) ? 7'b1001111:
        (bcd==2) ? 7'b0010010:
        (bcd==3) ? 7'b0000110:
        (bcd==4) ? 7'b1001100:
        (bcd==5) ? 7'b0100100:
        (bcd==6) ? 7'b0100000:
        (bcd==7) ? 7'b0001111:
        (bcd==8) ? 7'b0000000:
        (bcd==9) ? 7'b0000100:
        7'b1111111;

endmodule

module BCD27seg_topmodule (
    input [3:0] x0, x1, x2, x3,
    output [6:0] seg0, seg1, seg2, seg3
);

BCD27seg led1 (
    .bcd(x0), .seg(seg0)
);
BCD27seg led2 (
    .bcd(x1), .seg(seg1)
);
BCD27seg led3 (
    .bcd(x2), .seg(seg2)
);
BCD27seg led4 (
    .bcd(x3), .seg(seg3)
);
    
endmodule