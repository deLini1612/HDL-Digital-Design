module tb_control ();
    reg clk, rst_n;       //clock and active low reset signal
    reg request_i;        //input from datapath: = 1 if has request at floor i (i is current floor)
    reg request_j_gt_i;   //input from datapath: = 1 if has request at floor j > i (i is current floor)
    reg request_j_lt_i;   //input from datapath: = 1 if has request at floor j < i (i is current floor)
    wire open;            //open door control
    reg close;          //state the elevator is close (control by submodule open_close_door)
    wire up, down;   

    control duv
    (
        .clk(clk),
        .rst_n(rst_n),
        .request_i(request_i),
        .request_j_gt_i(request_j_gt_i),
        .request_j_lt_i(request_j_lt_i),
        .open(open),
        .close(close),
        .up(up),
        .down(down)
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

    // initial request_i
    initial begin
        request_i = 0;
        #70 request_i = 1;
        #20 request_i = 0;
        #80 request_i = 1;
        #20 request_i = 0;
    end

    // initial request_j_gt_i
    initial begin
        request_j_gt_i = 0;
        #70 request_j_gt_i = 1;
        #120 request_j_gt_i = 0;
    end

    // initial request_j_lt_i
    initial begin
        request_j_lt_i = 0;
    end

    // initial close
    initial begin
        close = 1;
        #90 close = 0;
        #40 close = 1;
        #60 close = 0;
        #40 close = 1;
    end
    
endmodule