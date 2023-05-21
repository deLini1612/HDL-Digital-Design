module clock_top_module (
    input built_in_clk, glob_rst_n,
    output [6:0] seg0_s, seg1_s,
    output [6:0] seg0_mi, seg1_mi,
    output [6:0] seg0_h, seg1_h,
    output [6:0] seg0_d, seg1_d,
    output [6:0] seg0_mo, seg1_mo,
    output [6:0] seg0_y, seg1_y, seg2_y, seg3_y
);

    wire clk, is_leap;
    wire [4:0] carry_out;

    // Generate clk 1Hz
    clk_1Hz clk1hz(
        .built_in_clk(built_in_clk),
        .clk(clk)
    );

    // Count and display
    cnt_dis_secmin sec(
        .clk(clk),
        .ce(1'b1),
        .glob_rst_n(glob_rst_n),
        .carry_out(carry_out[0]),
        .seg0(seg0_s),
        .seg1(seg1_s)
    );

    cnt_dis_secmin min(
        .clk(clk),
        .ce(carry_out[0]),
        .glob_rst_n(glob_rst_n),
        .carry_out(carry_out[1]),
        .seg0(seg0_mi),
        .seg1(seg1_mi)
    );

    cnt_dis_hour hour (
        .clk(clk),
        .ce(carry_out[1]),
        .glob_rst_n(glob_rst_n),
        .carry_out(carry_out[2]),
        .seg0(seg0_h),
        .seg1(seg1_h)
    );

    cnt_dis_day day (
        .seg0_mon(seg0_mo),
        .seg1_mon(seg0_mo),
        .is_leap(is_leap),
        .clk(clk),
        .ce(carry_out[2]),
        .glob_rst_n(glob_rst_n),
        .carry_out(carry_out[3]),
        .seg0(seg0_d),
        .seg1(seg1_d)
    );

    cnt_dis_month month (
        .clk(clk),
        .ce(carry_out[3]),
        .glob_rst_n(glob_rst_n),
        .carry_out(carry_out[4]),
        .seg0(seg0_mo),
        .seg1(seg1_mo)
    );

    cnt_dis_year duv (
        .clk(clk),
        .ce(carry_out[4]),
        .glob_rst_n(glob_rst_n),
        .seg0(seg0_y),
        .seg1(seg1_y),
        .seg2(seg2_y),
        .seg3(seg3_y),
        .is_leap(is_leap)
    );

endmodule