// counter with ce signal (counter enable)
module counter #(
    parameter NUMBER_OF_BIT,
    parameter RST_INIT,
    parameter RST_VALUE
) (
    input clk, ce, glob_rst_n,
    output reg [NUMBER_OF_BIT-1:0] cnt = RST_INIT,
    output reg carry_out = 0
);
    
    reg [NUMBER_OF_BIT-1:0] cnt_next;
    always @(cnt or ce) begin
        cnt_next = cnt + ce;
        carry_out = (cnt==RST_VALUE - 1)&(cnt_next == RST_VALUE);
    end

    always @(posedge clk or negedge glob_rst_n) begin
        if (~glob_rst_n) cnt <= RST_INIT;
        else 
            if (ce) begin
                if (cnt == RST_VALUE - 1) begin
                    cnt <= RST_INIT;
                end
                else begin
                    cnt <= cnt + 1;
                end
            end
            else begin
                cnt <= cnt;
            end
    end
endmodule