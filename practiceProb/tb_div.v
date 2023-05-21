`timescale 1ps/1ps
module tb_div ();

    reg clk;
    reg [7:0]a;
    reg [7:0]b;
    reg start;
    wire [7:0] res;
    wire [7:0] mod;
    wire cal, done;

    div #(.WIDTH(8)) duv (
        .clk(clk),
        .a(a),
        .b(b),
        .start(start),
        .res(res),
        .mod(mod),
        .cal(cal),
        .done(done)
    );


    // Generate clk 1Hz
    initial begin
		clk = 1;
		repeat(500) #5 clk = ~clk;
	end

    //generate input
    initial begin
        a = $random;
        b = $random;
        #100 b = 4'd10;
        a = $random;
        #100 b = 4'd5;
        a = 13'd109;
        repeat(20) begin
            #100 b = $random;
            a = $random;
        end
    end

    initial begin
        #10 start = 1;
	    #10 start = 0;
        repeat(22) begin
            #90 start = 1;
            #10 start = 0;      
        end
    end

endmodule