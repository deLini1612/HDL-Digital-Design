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
    output          tx_ready,   // = 1: transmitter is ready to transmit
    output          Tx,
    output          d_out_valid,    // = 1: d_out is valid
    output  [7:0]   d_out,
    output          parity_err,
    ouput           frame_err
);

    wire enable;
    
    clk_div #(
        .DIV_VAL(SYS_FREQ/(BAUD_RATE*16)),
        .DIV_POS(SYS_FREQ/(BAUD_RATE*16) - 1)
    ) gen_enable_tick (
        .clk(clk),
        .rst_n(rst_n),
        .enable(1),
        .tick(enable),
        .clear(0)
    );


    Tx #(
        .SAMPLE(SAMPLE)
    ) transmiter (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .send_req(send_req),
        .d_in(d_in),
        .tx_ready(tx_ready),
        .Tx(Tx)
    );

    Rx #(
        .SAMPLE(SAMPLE)
    )duv (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .Rx(Rx),
        .d_out_valid(d_out_valid),
        .d_out(d_out),
        .parity_err(parity_err),
        .frame_err(frame_err)
    );
endmodule