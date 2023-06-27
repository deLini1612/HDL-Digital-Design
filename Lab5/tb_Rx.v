module tb_Rx();

    reg clk, rst_n;
    reg Rx;
    wire recv_req;
    wire [7:0] d_out;

    Rx duv (
        .clk(clk),
        .rst_n(rst_n),
        // .SYMBOL_WIDTH(4),
        .SYMBOL_WIDTH(5),
        .Rx(Rx),
        .recv_req(recv_req),
        .d_out(d_out)
    );

    initial begin
        clk = 0;
        repeat(4000) #10 clk = ~clk;
    end

    initial begin
        rst_n = 1;
        #10 rst_n = 0;
	    #20 rst_n = 1;
    end

    // Init Rx
    initial begin
        Rx = 1'b1;
        #90 Rx = 1'b0;
        #100 Rx = 1'b1;
        #100 Rx = 1'b0;
        #100 Rx = 1'b0;
        #100 Rx = 1'b1;
        #100 Rx = 1'b0;
        #100 Rx = 1'b1;
        #100 Rx = 1'b1;
        #100 Rx = 1'b0;
        #100 Rx = 1'b1;
        #280 Rx = 1'b0;
        repeat(8) #100 Rx = $random;
        #100 Rx = 1'b1;
    end

endmodule