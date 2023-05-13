`timescale 1ps/1ps
module testbench_CRA_8bits();
    reg [7:0] a, b;
    wire [7:0] s;
    wire co;

    CRA_8bits duv (
        .a(a),
        .b(b),
        .s(s),
        .co(co)
    );

    // Generate full test input
    initial begin
        for (a = 0; a < 255; a = a + 1) begin
            for (b = 0; b < 255; b = b + 1) begin
                #1;
                if (b==254) begin
                    b = 255;
                    #1;
                    b = 254;
                end 
            end

            if (a == 254) begin
                a = 255;
                for (b = 0; b < 255; b = b + 1) begin
                    #1;
                    if (b==254) begin
                        b = 255;
                        #1;
                        b = 254;
                    end 
                end
                a = 254;
            end          
        end
    end

    // Generate golden output
    wire [7:0] golden_s;
    wire [8:0] temp;
    wire golden_co;
    assign golden_s = a + b;
    assign temp = a + b;
    assign golden_co = temp[8];

    //Compare and warn if different
    initial begin
        if ((golden_s != s) | (golden_co != co)) begin
           $monitor("[%0t] Error: a = %b, b = %b, golden_s = %b, golden_co = %b, s = %b, co = %b",
                $time, a, b, golden_s, golden_co, s, co); 
        end
        else begin
            $monitor("[%0t] Pass: a = %b, b = %b, golden_s = s = %b, golden_co = co = %b",
                $time, a, b, s, co);
        end
    end

endmodule