`timescale 1ps/1ps
module tb_timer();
    reg clk, glob_rst_n;
    reg start;
    wire counting;
    wire timeout;

    timer #(.TIME(12), .WIDTH(4)) duv (
        .clk(clk),
        .glob_rst_n(glob_rst_n),
        .start(start),
        .counting(counting),
        .timeout(timeout)
    );

    // Generate clk
    initial begin
        clk = 1;
        repeat(100) #1 clk = ~clk;
    end

    initial begin
        glob_rst_n = 1;
        #10 glob_rst_n = 0;
        #2 glob_rst_n = 1;
        #36 glob_rst_n = 0;
        #2 glob_rst_n = 1;
    end

    initial begin
        start = 1;
        #2 start = 0;
        #14 start = 1;
        #2 start = 0;
        #40 start = 1;
        #2 start = 0;
    end
endmodule