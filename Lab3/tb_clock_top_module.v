`timescale 1ns/100ps
module tb_clock_top_module ();
    reg built_in_clk, glob_rst_n;
    wire [6:0] seg0_s, seg1_s;
    wire [6:0] seg0_mi, seg1_mi;
    wire [6:0] seg0_h, seg1_h;
    wire [6:0] seg0_d, seg1_d;
    wire [6:0] seg0_mo, seg1_mo;
    wire [6:0] seg0_y, seg1_y, seg2_y, seg3_y;

    clock_top_module duv(
        .built_in_clk(built_in_clk),
        .glob_rst_n(glob_rst_n),
        .seg0_s(seg0_s), .seg1_s(seg1_s),
        .seg0_mi(seg0_mi), .seg1_mi(seg1_mi),
        .seg0_h(seg0_h), .seg1_h(seg1_h),
        .seg0_d(seg0_d), .seg1_d(seg1_d),
        .seg0_mo(seg0_mo), .seg1_mo(seg1_mo),
        .seg0_y(seg0_y), .seg1_y(seg1_y), .seg2_y(seg2_y), .seg3_y(seg3_y)
    );

    // Generate input clock
    initial begin
        built_in_clk = 1;
        // f = 50MHz -> T = 20ns
        forever #10 built_in_clk = ~built_in_clk;
    end

    initial begin
        glob_rst_n = 0;
        #20 glob_rst_n = 1;
    end

endmodule

