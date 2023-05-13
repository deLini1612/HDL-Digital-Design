`timescale 1ns/100ps
module tb_clk_1Hz ();
    reg built_in_clk;
    wire clk;

    clk_1Hz duv(
        .built_in_clk(built_in_clk),
        .clk(clk)
    );

    // Generate input clock
    initial begin
        built_in_clk = 1;
        // f = 50MHz -> T = 20ns
        forever #10 built_in_clk = ~built_in_clk;
    end

endmodule

