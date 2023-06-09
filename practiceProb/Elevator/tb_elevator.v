module tb_elevator ();
    reg clk, rst_n;
    reg [3:0] button_out; // nut yeu cau di len/xuong ngoai thang may
    reg [3:0] button_in;  // nut chon tang ben trong thang may
    wire open, close, up, down;   //cac nut dieu khien dong, mo, di len, di xuong
    wire [3:0] current_floor;
    wire [3:0] request;
    
    elevator #(.TIME(3), .n(4), .WIDTH(2)) duv
    (
        .clk(clk),
        .rst_n(rst_n),
        .button_out(button_out),
        .button_in(button_in),
        .open(open),
        .close(close),
        .up(up),
        .down(down),
        .current_floor(current_floor),
        .request(request)
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
        button_out = 4'b1111;
        button_in = 4'b1111;
        #50;
        button_out = 4'b1010;
        #20;
        button_out = 4'b1111;
        #100 button_out = $random;
        #20 button_out = 4'b1111;
        #200 button_out = $random;
        #20 button_out = 4'b1111;
    end
endmodule