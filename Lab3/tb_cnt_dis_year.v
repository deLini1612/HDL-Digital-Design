`timescale 100ms/1us
module tb_cnt_dis_year ();
    reg clk, glob_rst_n, ce;
    wire [6:0] seg3, seg2, seg1, seg0;
    wire is_leap;

    cnt_dis_year duv (
        .clk(clk),
        .ce(ce),
        .glob_rst_n(glob_rst_n),
        .seg0(seg0),
        .seg1(seg1),
        .seg2(seg2),
        .seg3(seg3),
        .is_leap(is_leap)
    );


    // Generate clk 1Hz
    initial begin
		clk = 1;
		repeat(8000) #5 clk = ~clk;
	end

    // Generate input randomly
    initial begin
		ce = 1;
		repeat(2000) #20 ce = $random;
	end

      
    initial begin
	    glob_rst_n = 0;
        #10 glob_rst_n = 1;
	end

endmodule