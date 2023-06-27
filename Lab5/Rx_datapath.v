module Rx_datapath (
    input clk, rst_n,
    input Rx,
    input [15:0] SYMBOL_WIDTH,      // = clk_freq/baud_rate
    input get, inc_i, inc_t, reset_i, reset_t, done,
    input recv_req,
    output i_eq_10, t_eq_sym_wid, t_eq_hal_sym_wid,
    output reg [7:0] d_out
);

    reg [3:0] i;
    reg [15:0] t;
    reg [9:0] buffer;

    assign i_eq_10 = (i==9)&t_eq_sym_wid;
    assign t_eq_sym_wid = (t == SYMBOL_WIDTH-1);
    // assign t_eq_hal_sym_wid = (t == (SYMBOL_WIDTH/2 - 1));
    assign t_eq_hal_sym_wid = ((t+t) == (SYMBOL_WIDTH- 1)) | ((t+t) == SYMBOL_WIDTH - 2);

    always @(done) begin
        if (done) d_out = buffer[8:1];
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            i <= 0;
            t <= 0;
            buffer <= 10'b0000000000;
        end
        else begin 
            if(get) begin
                buffer <= {buffer[8:0], Rx};
                // i <= 0;
                // t <= 0;
            end
            if (~recv_req) begin
                if (inc_t) t <= t+1;
                if (inc_i) i <= i+1;
                if (reset_i) i <= 0;
                if (reset_t) t <= 0;     
            end
        end
    end

endmodule