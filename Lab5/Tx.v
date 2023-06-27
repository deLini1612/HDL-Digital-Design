// Tx of UART
module Tx (
    input clk, rst_n, send_req,
    input [15:0] SYMBOL_WIDTH,       // = clk_freq/baud_rate
    input [7:0] d_in,
    output send_ack,
    output Tx
);

    wire load_bit, inc_i, inc_t, reset_i, reset_t, i_eq_10, t_eq_sym_wid;

Tx_datapath tx_dp (
    .clk(clk), .rst_n(rst_n),
    .d_in(d_in),
    .SYMBOL_WIDTH((SYMBOL_WIDTH)),
    .load_bit(load_bit),
    .inc_i(inc_i),
    .inc_t(inc_t),
    .reset_i(reset_i),
    .reset_t(reset_t),
    .send_ack(send_ack),
    .i_eq_10(i_eq_10),
    .t_eq_sym_wid(t_eq_sym_wid),
    .Tx(Tx)
);

Tx_control tx_ctr (
    .clk(clk), .rst_n(rst_n),
    .send_req(send_req),
    .i_eq_10(i_eq_10),
    .t_eq_sym_wid(t_eq_sym_wid),
    .load_bit(load_bit),
    .inc_i(inc_i),
    .inc_t(inc_t),
    .reset_i(reset_i),
    .reset_t(reset_t),
    .send_ack(send_ack)
);

endmodule