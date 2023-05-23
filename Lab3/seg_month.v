module seg_month (
    input [3:0]value,
    output reg [6:0]seg0, seg1 // seg1: chuc, seg0: dv
);
    
    always @(value) begin
        case (value)

            1: {seg1, seg0} = 14'b0000001_1001111;
            2: {seg1, seg0} = 14'b0000001_0010010;
            3: {seg1, seg0} = 14'b0000001_0000110;
            4: {seg1, seg0} = 14'b0000001_1001100;
            5: {seg1, seg0} = 14'b0000001_0100100;
            6: {seg1, seg0} = 14'b0000001_0100000;
            7: {seg1, seg0} = 14'b0000001_0001111;
            8: {seg1, seg0} = 14'b0000001_0000000;
            9: {seg1, seg0} = 14'b0000001_0000100;

            10: {seg1, seg0} = 14'b1001111_0000001;
            11: {seg1, seg0} = 14'b1001111_1001111;
            12: {seg1, seg0} = 14'b1001111_0010010;

            default: {seg1, seg0} = 14'b1111111_1111111;
        endcase
    end

endmodule