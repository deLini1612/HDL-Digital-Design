module seg_hour (
    input [4:0]value,
    output reg [6:0]seg0, seg1 // seg1: chuc, seg0: dv
);
    
    always @(value) begin
        case (value)

            0: {seg1, seg0} = 14'b0000001_0000001;
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
            13: {seg1, seg0} = 14'b1001111_0000110;
            14: {seg1, seg0} = 14'b1001111_1001100;
            15: {seg1, seg0} = 14'b1001111_0100100;
            16: {seg1, seg0} = 14'b1001111_0100000;
            17: {seg1, seg0} = 14'b1001111_0001111;
            18: {seg1, seg0} = 14'b1001111_0000000;
            19: {seg1, seg0} = 14'b1001111_0000100;

            20: {seg1, seg0} = 14'b0010010_0000001;
            21: {seg1, seg0} = 14'b0010010_1001111;
            22: {seg1, seg0} = 14'b0010010_0010010;
            23: {seg1, seg0} = 14'b0010010_0000110;

            default: {seg1, seg0} = 14'b1111111_1111111;
        endcase
    end

endmodule