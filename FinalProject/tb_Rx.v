`timescale 10ps/1ps
module tb_Rx();

    reg clk, rst_n;
    wire enable;
    reg Rx;
    wire d_out_valid, parity_err, frame_err;
    wire [7:0] d_out;

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

    Rx #(
        .SAMPLE(16)
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

    initial begin
        clk = 0;
        repeat(40000) #10 clk = ~clk;
    end

    initial begin
        rst_n = 1;
        #10 rst_n = 0;
	    #20 rst_n = 1;
    end

    // Init Rx
    initial begin
        Rx = 1'b1;
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
        #3200 Rx = 1'b0;
        repeat(8) #3200 Rx = $random;
        #3200 Rx = 1'b1;
    end

endmodule