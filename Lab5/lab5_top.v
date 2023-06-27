module lab5_top (
    input clk1, rst_n1, clk2, rst_n2,
    input send_req1, send_req2,
    output send_ack1, send_ack2,
    output recv_req1, recv_req2,
    input [7:0] d_in1, d_in2,
    output [7:0] d_out1, d_out2
);

    wire R1T2, T1R2;
    
    UART uart1 (
        .clk(clk1), .rst_n(rst_n1),
        .SYMBOL_WIDTH(4),
        .send_req(send_req1),
        .Rx(R1T2),
        .d_in(d_in1),
        .send_ack(send_ack1),
        .recv_req(recv_req1),
        .Tx(T1R2),
        .d_out(d_out1)
    );

    UART uart2 (
        .clk(clk2), .rst_n(rst_n2),
        .SYMBOL_WIDTH(4),
        .send_req(send_req2),
        .Rx(T1R2),
        .d_in(d_in2),
        .send_ack(send_ack2),
        .recv_req(recv_req2),
        .Tx(R1T2),
        .d_out(d_out2)
    );
endmodule