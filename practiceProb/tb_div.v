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
        a[12] = 1;
        b[3] = 1;
        repeat(500) begin
            a[11:0] = $random;
            b[2:0] = $random;
            #1;
        end
        b = 4'd10;
        repeat(100) #1 a[11:0] = $random;
        b = 4'd13;
        repeat(100) #1 a[11:0] = $random;
    end

    //generate golden output
    reg [9:0] golden_res;
    reg [3:0] golden_mod;
    always @(a or b) begin
        golden_mod = a%b;
        golden_res = a/b;
    end

    // Compare and warn if different
    initial begin
        if ((golden_res!=res)|(golden_mod!=mod)) begin
           $monitor("[%0t] Error: a = %d, b = %d, golden_res = %d, test_res = %d, golden_mod = %d, test_mod = %d",
                $time, a, b, golden_res, res, golden_mod, mod); 
        end
        else begin
            $monitor("[%0t] Pass: %d/%d = %d mod %d",
                $time, a, b, res, mod);
        end
    end
    
endmodule