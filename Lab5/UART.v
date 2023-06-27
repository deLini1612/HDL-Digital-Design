// a simple UART
module UART (
    input clk, rst_n,
    input [15:0] SYMBOL_WIDTH,       // = clk_freq/baud_rate
    input send_req,
    input Rx,
    input [7:0] d_in,
    output send_ack, recv_req,
    output Tx,
    output [7:0] d_out
);

    Rx Recv (
        .clk(clk),
        .rst_n(rst_n),
        .SYMBOL_WIDTH(SYMBOL_WIDTH),
        .Rx(Rx),
        .recv_req(recv_req),
        .d_out(d_out)
    );

    Tx Trans (
        .clk(clk),
        .rst_n(rst_n),
        .send_req(send_req),
        .SYMBOL_WIDTH(SYMBOL_WIDTH),
        .d_in(d_in),
        .send_ack(send_ack),
        .Tx(Tx)
    );

endmodule