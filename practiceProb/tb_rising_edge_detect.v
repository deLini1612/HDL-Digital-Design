`timescale 1ps/1ps
module tb_rising_edge_detect ();
    
    reg clk, rst_n, in;
    wire moore, mealy, direct;

    rising_edge_moore duv_moore(
        .clk(clk),
        .rst_n(rst_n),
        .in(in),
        .tick(moore)
    );

    rising_edge_moore duv_mealy(
        .clk(clk),
        .rst_n(rst_n),
        .in(in),
        .tick(mealy)
    );

    rising_edge_moore duv_direct(
        .clk(clk),
        .rst_n(rst_n),
        .in(in),
        .tick(direct)
    );

    //generate clk
    initial begin
        clk = 0;
        repeat(60) #1 clk = ~clk;
    end

    initial begin
        rst_n = 1;
        #20 rst_n = 0;
        #2 rst_n = 1;
    end

    initial begin
        repeat(30) #2 in = $random;
    end
endmodule