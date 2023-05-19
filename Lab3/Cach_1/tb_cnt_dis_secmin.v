`timescale 100ms/1us
module tb_cnt_dis_secmin ();
    reg clk, glob_rst_n, ce;
    wire carry_out;
    wire [6:0] seg1, seg0;

    cnt_dis_secmin duv (
        .clk(clk),
        .ce(ce),
        .glob_rst_n(glob_rst_n),
        .carry_out(carry_out),
        .seg0(seg0),
        .seg1(seg1)
    );

    // Generate clk 1Hz
    initial begin
		clk = 1;
		repeat(800) #5 clk = ~clk;
	end

    // Generate input randomly
    initial begin
		ce = 1;
		repeat(20) #200 ce = $random;
	end
    initial begin
		glob_rst_n = 1;
		repeat(5) #800 glob_rst_n = $random;
	end

endmodule