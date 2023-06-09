module tb_elevator ();
    reg clk, rst_n;
    reg [4:0] button_out; // nut yeu cau di len/xuong ngoai thang may
    reg [4:0] button_in;  // nut chon tang ben trong thang may
    wire open, close_n, up, down;   //cac nut dieu khien dong, mo, di len, di xuong
    wire [4:0] current_floor;
    
    elevator #(.TIME(4), .n(5)) duv
    (
        .clk(clk),
        .rst_n(rst_n),
        .button_out(button_out),
        .button_in(button_in),
        .open(open),
        .close_n(close_n),
        .up(up),
        .down(down),
        .current_floor(current_floor)
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


endmodule