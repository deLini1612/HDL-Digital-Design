module tb_open_close_door ();

    reg clk, rst_n;
    reg open;
    wire close_n;

    open_close_door #(.TIME(4)) duv 
    (
        .clk(clk),
        .rst_n(rst_n),
        .open(open),
        .close_n(close_n)
    );

    initial begin
        clk = 0;
        repeat(1000) #10 clk = ~clk;
    end
    
    initial begin
        rst_n = 1;
        #10 rst_n = 0;
	    #20 rst_n = 1;
    end

    initial begin
        #50
        repeat (100) begin
            open = $random;
            if (open == 1) #20 open = 0;
            #120;
        end
    end

endmodule