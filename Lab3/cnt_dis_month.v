// Count and display 2 digits for month
module cnt_dis_month (
    input clk, glob_rst_n, ce,
    output carry_out,
    output [6:0] seg1, seg0
);
    wire [3:0] cnt;

    counter #(.NUMBER_OF_BIT(4), .RST_INIT(1), .RST_VALUE(4'd13)) cnt60 (
        .clk(clk),
        .ce(ce),
        .glob_rst_n(glob_rst_n),
        .cnt(cnt),
        .carry_out(carry_out)
    );

    seg_month dis60(
        .value(cnt),
        .seg0(seg0),
        .seg1(seg1)
    );

endmodule