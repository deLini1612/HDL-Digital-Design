module clk_div 
# (
    parameter DIV_VAL = 16,
    parameter DIV_POS = 1  
)(
    input   clk,
    input   rst_n,
    output  tick
);

localparam DIV_WIDTH = $clog2(DIV_VAL+1);
reg [DIV_WIDTH - 1: 0] div_cnt;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
        div_cnt <= 0;
    else if (div_cnt == DIV_VAL -1)
        div_cnt <= 0;
    else div_cnt <= div_cnt + 1;
end

assign tick = (div_cnt == DIV_POS)?1:0;

endmodule