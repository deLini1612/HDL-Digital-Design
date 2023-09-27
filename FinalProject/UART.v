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



endmodule