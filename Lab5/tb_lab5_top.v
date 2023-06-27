module tb_lab5_top();
    reg clk1, rst_n1, clk2, rst_n2;
    reg send_req1, send_req2;
    wire send_ack1, send_ack2;
    wire recv_req1, recv_req2;
    reg [7:0] d_in1, d_in2;
    wire [7:0] d_out1, d_out2;

    lab5_top duv (
        .clk1(clk1), .rst_n1(rst_n1),
        .clk2(clk2), .rst_n2(rst_n2),
        .send_req1(send_req1), .send_req2(send_req2),
        .send_ack1(send_ack1), .send_ack2(send_ack2),
        .recv_req1(recv_req1), .recv_req2(recv_req2),
        .d_in1(d_in1), .d_in2(d_in2),
        .d_out1(d_out1), .d_out2(d_out2)
    );

    initial begin
        clk1 = 0;
        repeat(400) #10 clk1 = ~clk1;
    end
    initial begin
        rst_n1 = 1;
        #10 rst_n1 = 0;
	    #20 rst_n1 = 1;
    end

    initial begin
        #50 d_in1 = 8'b10011010;
        send_req1 = 1;
        #20 send_req1 = 0;
        #1000;
        #40 d_in1 = $random;
        #40 send_req1 = 1;
        #20 send_req1 = 0;
        #1000;
    end

// UART 2
    initial begin
        clk2 = 0;
        repeat(400) #10 clk2 = ~clk2;
    end
    initial begin
        rst_n2 = 1;
        #10 rst_n2 = 0;
	    #20 rst_n2 = 1;
    end
    initial begin
        #90 d_in2 = 8'b00110100;
        #20 send_req2 = 1;
        #20 send_req2 = 0;
        #200 d_in2 = $random;
        #800;
        #40 d_in2 = $random;
        #40 send_req2 = 1;
        #20 send_req2 = 0;
        #1000;
    end
endmodule