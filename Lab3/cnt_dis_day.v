// Module to decide number of days and count
module count_day(
    input clk, ce, glob_rst_n,
    input [4:0] RST_VALUE,
    output reg [4:0] cnt = 1,
    output reg carry_out = 0
);
    
    always @(posedge clk or negedge glob_rst_n) begin
        if (~glob_rst_n) cnt <= 1'b1;
        else 
            if (ce) begin
                if (cnt == RST_VALUE) begin
                    cnt <= 1'b1;
                end
                else begin
                    cnt <= cnt + 1;
                end
            end
            else begin
                cnt <= cnt;
            end
    end

    always @(posedge clk or negedge glob_rst_n) begin
        carry_out = ((cnt==RST_VALUE)&&(ce))?1:0;
    end
endmodule

module cnt_dis_day (
    input [6:0] seg1_mon, seg0_mon,
    input is_leap,
    input clk, glob_rst_n, ce,
    output carry_out,
    output [6:0] seg1, seg0
    );

    wire [4:0] cnt;
    reg [4:0] RST_VALUE;

    always @(seg1_mon or seg0_mon or is_leap) begin
        case ({seg1_mon,seg0_mon})
            14'b00000010_010010 : RST_VALUE = (is_leap==1)?29:28;
            14'b00000011_001100 : RST_VALUE = 30; // thang 4
            14'b00000010_100000 : RST_VALUE = 30; // thang 6
            14'b00000010_000100 : RST_VALUE = 30; //thang 9
            14'b1001111_1001111 : RST_VALUE = 30; //thang 11
            default: RST_VALUE = 31;
        endcase
    end

    count_day count_d(
        .clk(clk), .ce(ce), .glob_rst_n(glob_rst_n),
        .RST_VALUE(RST_VALUE),
        .cnt(cnt),
        .carry_out(carry_out)
    );

    seg_day dis_day(
        .value(cnt),
        .seg0(seg0),
        .seg1(seg1)
    );

endmodule