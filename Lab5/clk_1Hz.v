// Generate 1Hz clock from 50M built-in clk
module clk_1Hz #(
    parameter BUILT_IN_FREQ = 27'd50000000,
    parameter DIVISOR = 27'd50000000
) (
    input built_in_clk,
    output reg clk
);

reg[26:0] counter=27'd0;
always @(posedge built_in_clk)
begin
    counter <= counter + 27'd1;
    if(counter>=(DIVISOR-1))
        counter <= 27'd0;
    clk <= (counter<DIVISOR/2)?1'b1:1'b0;
end

endmodule