`timescale 10ps/1ps

module tb_debouncer();

    reg clk, rst_n, signal_in;
    wire debouned_signal;

    debouncer #(
        .LATENCY(3)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .signal_in(signal_in),
        .debouned_signal(debouned_signal)
    );

    initial begin
        clk = 0;
        repeat(200) #10 clk = ~clk;
    end

    initial begin
        rst_n = 1;
        #10 rst_n = 0;
	    #20 rst_n = 1;
    end

    initial begin
        #50 signal_in = 0;
        #5 signal_in = 1;
        #5 signal_in = 0;
        #20 signal_in = 1;
        #10 signal_in = 0;
        #300 signal_in = 1;
        #5 signal_in = 0;
        #5 signal_in = 1;
        #5 signal_in = 0;
        #10 signal_in = 1;
        #5 signal_in = 0;
        #10 signal_in = 1;
        #5 signal_in = 0;
        #5 signal_in = 1;
        #40 signal_in = 0;
        #5 signal_in = 1;
        #300 signal_in = 0;
        #10 signal_in = 1;
        #5 signal_in = 0;
        #10 signal_in = 1;
        #5 signal_in = 0;
        #300 signal_in = 1;
        #20 signal_in = 0;
        #20 signal_in = 1;
        #20 signal_in = 0;
        #200;
    end

endmodule