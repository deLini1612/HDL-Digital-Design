module clock_topmodule (
    input built_in_clk, glob_rst_n,
    output [6:0] s_sec0, s_sec1,
    output [6:0] s_min0, s_min1,
    output [6:0] s_hour0, s_hour1,
    output [6:0] s_day0, s_day1,
    output [6:0] s_mon0, s_mon1,
    output [6:0] s_year0, s_year1, s_year2, s_year3
);
    wire [5:0] sec, min;
    wire [4:0] hour, day;
    wire [3:0] mon;
    wire [13:0] year;
    wire [7:0] digit_sec, digit_min, digit_hour, digit_day, digit_mon;
    wire [15:0] digit_year;

    // Generate clk 1Hz 
    //use divisor = 5000 to create clk 10000hz for quick verification
    clk_1Hz #(.DIVISOR(27'd5000)) clk1hz(
        .built_in_clk(built_in_clk),
        .clk(clk)
    );

    // Count
    timer count_clk(
        .clk(clk),
        .glob_rst_n(glob_rst_n),
        .sec(sec),
        .min(min),
        .hour(hour),
        .day(day),
        .mon(mon),
        .year(year)
    );

    // Digit count
    digit_clk digit (
        .sec(sec), .min(min), .hour(hour),
        .day(day), .mon(mon), .year(year),
        .digit_sec(digit_sec), .digit_min(digit_min), .digit_hour(digit_hour),
        .digit_day(digit_day), .digit_mon(digit_mon), .digit_year(digit_year)
    );

    // Display
    display_clk display(
        .digit_sec(digit_sec), .digit_min(digit_min), .digit_hour(digit_hour),
        .digit_day(digit_day), .digit_mon(digit_mon), .digit_year(digit_year),
        .s_sec0(s_sec0), .s_sec1(s_sec1),
        .s_min0(s_min0), .s_min1(s_min1),
        .s_hour0(s_hour0), .s_hour1(s_hour1),
        .s_day0(s_day0), .s_day1(s_day1),
        .s_mon0(s_mon0), .s_mon1(s_mon1),
        .s_year0(s_year0), .s_year1(s_year1), .s_year2(s_year2), .s_year3(s_year3)
    );

endmodule