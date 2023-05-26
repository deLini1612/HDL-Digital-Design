// timer count when receives start signal 
// then set a tick on timeout signal after count t second
module timer #(
    parameter TIME,
    parameter WIDTH
) (
    input clk, glob_rst_n,          // 1Hz clk and hard reset signal
    input start,                    // start = start timer
    output reg timeout              // timeout = done counting
);
    reg counting;            // counting = counting
    reg [WIDTH-1:0] cnt;
    always @(posedge clk or negedge glob_rst_n) begin
        if (~glob_rst_n) begin 
            cnt <= 0;
            counting <= 0;
            timeout <= 0;
        end
        else begin
            if (start) begin
            cnt <= 0;
            counting <= 1;
            timeout <= 0;
            end
            else 
                if (counting) begin
                    if (cnt == TIME - 1) begin
                        cnt <= 0;
                        counting <= 0;
                        timeout <= 1;
                    end
                    else cnt <= cnt +1;
                end
                else begin 
                    timeout <= 0;
                    cnt <= cnt;
                end
        end
    end
endmodule