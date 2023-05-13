// Count and display 2 digits for minute, second
module cnt_dis_secmin (
    input clk, glob_rst_n, ce,
    output carry_out,
    output [6:0] seg1, seg0
);
    wire [5:0] cnt;

    counter #(.NUMBER_OF_BIT(6), .RST_INIT(0), .RST_VALUE(6'd60)) cnt60 (
        .clk(clk),
        .ce(ce),
        .glob_rst_n(glob_rst_n),
        .cnt(cnt),
        .carry_out(carry_out)
    );

    seg_secmin dis60(
        .value(cnt),
        .seg0(seg0),
        .seg1(seg1)
    );

endmodule