module tb_control ();
    reg clk, rst_n;       //clock and active low reset signal
    reg request_i;        //input from datapath: = 1 if has request at floor i (i is current floor)
    reg request_j_gt_i;   //input from datapath: = 1 if has request at floor j > i (i is current floor)
    reg request_j_lt_i;   //input from datapath: = 1 if has request at floor j < i (i is current floor)
    wire open;            //open door control
    reg close_n;          //state the elevator is close (control by submodule open_close_door)
    wire up, down;   

    initial begin
        clk = 0;
        repeat(1000) #10 clk = ~clk;
    end
    
    initial begin
        rst_n = 1;
        #10 rst_n = 0;
	    #20 rst_n = 1;
    end
    
endmodule