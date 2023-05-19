`timescale 1ps/1ps
module tb_pattern110 ();

reg clk, rst_n, x;
wire y;

pattern110 duv (
    .clk(clk),
    .rst_n(rst_n),
    .x(x),
    .y(y)
);

// generate clk and input
initial begin
   clk = 1;
   repeat(100000) #10 clk = ~clk;
end

initial begin
    repeat(50000) #20 x = $random;
end

//generate rst_n
initial begin
    rst_n = 1;
    #100 rst_n = 0;
    #40 rst_n = 1;
    #620 rst_n = 0;
    #20 rst_n = 1;
end
    
endmodule