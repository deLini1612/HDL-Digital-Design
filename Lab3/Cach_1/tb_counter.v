`timescale 100ms/1us
module tb_counter ();
    reg clk, ce, glob_rst_n;
    wire [3:0] cnt;
    wire carry_out;

    counter #(.NUMBER_OF_BIT(4), .RST_INIT(0), .RST_VALUE(12)) duv (
        .clk(clk),
        .ce(ce),
        .glob_rst_n(glob_rst_n),
        .cnt(cnt),
        .carry_out(carry_out)
    );

    // Generate 1Hz clock and random input
	initial
	begin
		clk = 1;
        glob_rst_n = 1;
		repeat(800) #5 clk = ~clk;
	end

	initial begin
		ce = 1;
		repeat(200) #20 ce = $random;
	end

endmodule