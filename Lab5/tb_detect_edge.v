module tb_detect_edge ();
    
    reg clk, rst_n, Rx;
    wire change;

    detect_edge duv(
        .clk(clk),
        .rst_n(rst_n),
        .in(Rx),
        .change(change)
    );

    //generate clk
    initial begin
        clk = 0;
        repeat(400) #10 clk = ~clk;
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
        repeat(8) #20 Rx = $random;
        #20 Rx = 1'b1;
        #20 Rx = 1'b1;
        #100 Rx = 1'b0;
        repeat(8) #20 Rx = $random;
        #20 Rx = 1'b1;
    end
endmodule