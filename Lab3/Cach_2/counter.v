// counter with ce signal (counter enable)
module counter #(
    parameter NUMBER_OF_BIT, //number of bit to be count
    parameter RST_INIT      // value to be reset to
) (
    input clk, ce, glob_rst_n,
    input [5:0] RST_VALUE,  //max value need to rst is 60
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