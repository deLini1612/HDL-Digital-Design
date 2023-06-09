module tb_datapath ();
    reg clk, rst_n;
    reg open;
    reg up, down;           // signal open from control module
    reg [4:0] button_out; // nut yeu cau di len/xuong ngoai thang may
    reg [4:0] button_in;  // nut chon tang ben trong thang may
    wire request_i;         // = 1 if has request at floor i (i is current floor)
    wire request_j_gt_i;    // = 1 if has request at floor j > i (i is current floor)
    wire request_j_lt_i;    // = 1 if has request at floor j < i (i is current floor)
    wire [4:0] i;

    datapath  #(.n(5)) duv
    (
        .clk(clk),
        .rst_n(rst_n),
        .open(open),
        .up(up),
        .down(down),
        .button_out(button_out),
        .button_in(button_in),
        .request_i(request_i),
        .request_j_gt_i(request_j_gt_i),
        .request_j_lt_i(request_j_lt_i),
        .i(i)
    );


    initial begin
        clk = 0;
        repeat(30) #10 clk = ~clk;
    end
    
    initial begin
        rst_n = 1;
        #10 rst_n = 0;
	    #20 rst_n = 1;
    end

    initial begin
        button_out = 5'b11111;
        button_in = 5'b11111;
        #50;
        button_out = 5'b11010;
        button_in = 5'b11111;
        #20;
        button_out = 5'b11111;
        button_in = 5'b11111;
    end

    initial begin
    end
endmodule