// Rx of UART
module Rx (
    input clk, rst_n,
    input [15:0] SYMBOL_WIDTH,       // = clk_freq/baud_rate
    input Rx,
    output recv_req,
    output [7:0] d_out
);

    wire bit_begin, get, inc_i, inc_t, reset_i, reset_t, done;
    wire i_eq_10, t_eq_sym_wid, t_eq_hal_sym_wid;

    detect_edge detect (
        .clk(clk), .rst_n(rst_n),
        .in(Rx),
        .change(bit_begin)
    );

    Rx_datapath rx_dp (
        .clk(clk), .rst_n(rst_n),
        .Rx(Rx),
        .SYMBOL_WIDTH((SYMBOL_WIDTH)),
        .get(get),
        .inc_i(inc_i),
        .inc_t(inc_t),
        .reset_i(reset_i),
        .reset_t(reset_t),
        .done(done),
        .recv_req(recv_req),
        .i_eq_10(i_eq_10),
        .t_eq_sym_wid(t_eq_sym_wid),
        .t_eq_hal_sym_wid(t_eq_hal_sym_wid),
        .d_out(d_out)
    );

    Rx_control rx_ctr (
        .clk(clk), .rst_n(rst_n),
        .bit_begin(bit_begin),
        .i_eq_10(i_eq_10),
        .t_eq_sym_wid(t_eq_sym_wid),
        .t_eq_hal_sym_wid(t_eq_hal_sym_wid),
        .get(get),
        .inc_i(inc_i),
        .inc_t(inc_t),
        .reset_i(reset_i),
        .reset_t(reset_t),
        .done(done),
        .recv_req(recv_req)
    );

endmodule