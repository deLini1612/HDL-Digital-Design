module tb_Tx();

    reg clk, rst_n, send_req;
    reg [15:0] SYMBOL_WIDTH;
    reg [7:0] d_in;
    wire send_ack;
    wire Tx;

    Tx duv (
        .clk(clk),
        .rst_n(rst_n),
        .send_req(send_req),
        .SYMBOL_WIDTH(4),
        .d_in(d_in),
        .send_ack(send_ack),
        .Tx(Tx)
    );

    initial begin
        clk = 0;
        repeat(400) #10 clk = ~clk;
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
        #1000;
        #40 d_in = 8'b00010010;
        #40 send_req = 1;
        #20 send_req = 0;
        #1000;
    end

endmodule