// a simple UART
module UART #(
    parameter SYS_FREQ      =   50000000,
    parameter BAUD_RATE     =   9600,
    parameter DATA_SIZE     =   8,
    parameter STOP_SIZE     =   1,
    parameter SAMPLE        =   16
)(
    input           clk,
    input           rst_n,
    input           send_req,
    input           Rx,
    input   [7:0]   d_in,
    output          send_ack,   // = 1: transmitter is ready to transmit
    output          recv_req,
    output          Tx,
    output  [7:0]   d_out
);

    clk_div #(
        .DIV_VAL(SYS_FREQ/(SAMPLE*BAUD_RATE))
    ) gen_tick (
        .rst_n(rst_n),
        .clk(clk),
        .tick(tick)
    );

    Tx #(
        .SAMPLE(16),
        .DATA_SIZE(8),
        .STOP_SIZE(1),
    ) Trans (
        .clk(clk),
        .rst_n(rst_n),
        .enable(tick),
        .d_in(d_in),
        .send_req(send_req),
        .send_ack(send_ack),
        .Tx(Tx)
    );

endmodule