`timescale 10ps/1ps
module tb_clk_div ();
    reg clk, rst_n, clk_div_clr;
    wire enable2, tick;

    clk_div #(
        .DIV_VAL(20),
        .DIV_POS(19)
    ) duv1 (
        .clk(clk),
        .rst_n(rst_n),
        .enable(1),
        .tick(enable2),
        .clear(clk_div_clr)
    );

    clk_div #(
        .DIV_VAL(16),
        .DIV_POS(7)
    ) duv2 (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable2),
        .tick(tick),
        .clear(0)
    );

    // Generate input clock
    initial begin
        clk = 0;
        repeat(4000) #10 clk = ~clk;
    end

    initial begin
        rst_n = 1;
        #10 rst_n = 0;
	    #20 rst_n = 1;
    end

    initial begin
        clk_div_clr = 0;
        #50 clk_div_clr = 1;
	    #60 clk_div_clr = 0;
    end

endmodule

