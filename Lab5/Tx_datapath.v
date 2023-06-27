module Tx_datapath (
    input clk, rst_n,
    input [7:0] d_in,
    input [15:0] SYMBOL_WIDTH,      // = clk_freq/baud_rate
    input load_bit, inc_i, inc_t, reset_i, reset_t,
    input send_ack,
    output i_eq_10, t_eq_sym_wid, 
    output Tx
);

    reg [3:0] i;
    reg [15:0] t;
    reg [9:0] buffer;

    assign i_eq_10 = (i==9);
    assign t_eq_sym_wid = (t == SYMBOL_WIDTH-1);
    assign Tx = buffer[9];

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            i <= 0;
            t <= 0;
            buffer <= 10'b1111111111;
        end
        else begin 
            if(load_bit) begin
                buffer <= {1'b0, d_in, 1'b1};
                i <= 0;
                t <= 0;
            end
            else if (~send_ack) begin
                if (inc_t) t <= t+1;
                if (inc_i) begin 
                    i <= i+1;
                    buffer <= {buffer[8:0],1'b1};
                end
                if (reset_i) i <= 0;
                if (reset_t) t <= 0;
            end
        end
    end
endmodule