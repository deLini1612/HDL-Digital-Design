// Count and display 2 digits for hour
module cnt_dis_hour (
    input clk, glob_rst_n, ce,
    output carry_out,
    output [6:0] seg1, seg0
);
    wire [4:0] cnt;

    counter #(.NUMBER_OF_BIT(5), .RST_INIT(0), .RST_VALUE(5'd24)) cnt60 (
        .clk(clk),
        .ce(ce),
        .glob_rst_n(glob_rst_n),
        .cnt(cnt),
        .carry_out(carry_out)
    );

    seg_hour dis60(
        .value(cnt),
        .seg0(seg0),
        .seg1(seg1)
    );

endmodule