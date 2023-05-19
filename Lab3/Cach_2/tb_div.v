`timescale 1ps/1ps
module tb_div ();

    reg [12:0]a;
    reg [3:0]b;
    wire [9:0] res;
    wire [3:0] mod;

    div #(.WIDTH_DIVIDEND(13), .WIDTH_DIVISOR(4)) duv (
        .a(a),
        .b(b),
        .res(res),
        .mod(mod)
    );

    //generate input
    initial begin
        repeat(500) begin
            a = $random;
            b = $random;
            #1;
        end
        b = 4'd10;
        repeat(100) #1 a = $random;
        b = 4'd4;
        repeat(100) #1 a = $random;
    end

    // Print ans
    initial begin
        $monitor("[%0t]: %d/%d = %d mod %d",
            $time, a, b, res, mod);
    end
    
endmodule