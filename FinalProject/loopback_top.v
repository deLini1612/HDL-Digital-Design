module loopback_top #(
    parameter SYS_FREQ      =   50000000,
    parameter BAUD_RATE     =   9600,
    parameter SAMPLE        =   16
) (
    input   clk,
    input   rst_n,
    input   Rx,
    output  Tx,
    output  parity_err, // Just connect LED for status
    output  frame_err,  // Just connect LED for status
    output  tx_ready   // Just connect LED for status
);

    wire    [7:0]   data;
    wire            valid;

    UART #(
        .SYS_FREQ(SYS_FREQ),
        .BAUD_RATE(BAUD_RATE),
        .SAMPLE(SAMPLE)
    )
    loopback_uart (
        .clk(clk),
        .rst_n(rst_n),
        .send_req(valid),
        .Rx(Rx),
        .d_in(data),
        .tx_ready(tx_ready),
        .Tx(Tx),
        .d_out_valid(valid),
        .d_out(data),
        .parity_err(parity_err),
        .frame_err(frame_err)
    );
    
endmodule