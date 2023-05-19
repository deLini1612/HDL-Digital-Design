`timescale 1ps/1ps
module tb_digit_clk ();
    reg [5:0] sec, min;
    reg [4:0] hour, day;
    reg [3:0] mon;
    reg [13:0] year;
    wire [7:0] digit_sec, digit_min, digit_hour, digit_day, digit_mon;
    wire [15:0] digit_year;

    digit_clk duv (
        .sec(sec), .min(min), .hour(hour),
        .day(day), .mon(mon), .year(year),
        .digit_sec(digit_sec), .digit_min(digit_min), .digit_hour(digit_hour),
        .digit_day(digit_day), .digit_mon(digit_mon), .digit_year(digit_year)
    );

    //generate input
    initial begin
        repeat(700) begin
            sec = $random;
            min = $random;
            hour = $random;
            day = $random;
            mon = $random;
            year = $random;
            #1;
        end
    end

endmodule