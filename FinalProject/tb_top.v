`timescale 10ps/1ps
module tb_top();

    reg clk, rst_n, Rx;
    wire Tx, parity_err, frame_err, tx_ready;

    loopback_top #(
        .SYS_FREQ(160000000),
        .BAUD_RATE(1000000),
        .SAMPLE(16)
    ) duv (
        .clk(clk),
        .rst_n(rst_n),
        .Rx(Rx),
        .Tx(Tx),
        .parity_err(parity_err),
        .frame_err(frame_err),
        .tx_ready(tx_ready)
    );

    initial begin
        clk = 0;
        repeat(16000) #10 clk = ~clk;
    end

    initial begin
        rst_n = 1;
        #10 rst_n = 0;
	    #20 rst_n = 1;
    end

    // Init Rx
    initial begin
        Rx = 1'b1;
        // Frame 1
        #900 Rx = 1'b0;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b1;
        // Frame 2
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b1;
        // Frame 3
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b0;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b1;
        #3200 Rx = 1'b1;
        #3200;
    end

endmodule