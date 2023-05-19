`timescale 1ns/100ps
module tb_clock_topmodule ();
    reg built_in_clk, glob_rst_n;
    wire [6:0] s_sec0, s_sec1;
    wire [6:0] s_min0, s_min1;
    wire [6:0] s_hour0, s_hour1;
    wire [6:0] s_day0, s_day1;
    wire [6:0] s_mon0, s_mon1;
    wire [6:0] s_year0, s_year1, s_year2, s_year3;

    clock_topmodule duv(
        .built_in_clk(built_in_clk),
        .glob_rst_n(glob_rst_n),
        .s_sec0(s_sec0), .s_sec1(s_sec1),
        .s_min0(s_min0), .s_min1(s_min1),
        .s_hour0(s_hour0), .s_hour1(s_hour1),
        .s_day0(s_day0), .s_day1(s_day1),
        .s_mon0(s_mon0), .s_mon1(s_mon1),
        .s_year0(s_year0), .s_year1(s_year1), .s_year2(s_year2), .s_year3(s_year3)
    );

    // Generate input clock
    initial begin
        built_in_clk = 1;
        glob_rst_n = 1;
        // f = 50MHz -> T = 20ns
        forever #10 built_in_clk = ~built_in_clk;
    end

endmodule

