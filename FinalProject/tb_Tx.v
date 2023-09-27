`timescale 10ps/1ps

module tb_Tx();

    reg clk, rst_n, send_req;
    wire enable;
    reg [7:0] d_in;
    wire tx_ready;
    wire Tx;

    clk_div #(
        .DIV_VAL(10),
        .DIV_POS(9)
    ) gen_sample_tick (
        .clk(clk),
        .rst_n(rst_n),
        .enable(1),
        .tick(enable),
        .clear(0)
    );

    Tx #(
        .SAMPLE(16)
        ) duv (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .send_req(send_req),
        .d_in(d_in),
        .tx_ready(tx_ready),
        .Tx(Tx)
    );

    initial begin
        clk = 0;
        repeat(10000) #10 clk = ~clk;
    end

    initial begin
        rst_n = 1;
        #10 rst_n = 0;
	    #20 rst_n = 1;
    end

    initial begin
        #50 d_in = 8'b10011010;
        send_req = 1;
        #20 send_req = 0;
        #40000;
        #40 d_in = 8'b00010010;
        #40 send_req = 1;
        #20 send_req = 0;
        #40000;
    end

endmodule