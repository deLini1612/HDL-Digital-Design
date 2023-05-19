`timescale 1ps/1ps
module tb_timer ();
    reg clk, glob_rst_n;
    wire [5:0] sec, min;
    wire [4:0] hour, day;
    wire [3:0] mon;
    wire [13:0] year;

    timer duv (
        .clk(clk),
        .glob_rst_n(glob_rst_n),
        .sec(sec),
        .min(min),
        .hour(hour),
        .day(day),
        .mon(mon),
        .year(year)
    );

    //generate clock
    initial begin
		clk = 1;
        glob_rst_n = 1;
		repeat(800000) #1 clk = ~clk;
	end

endmodule