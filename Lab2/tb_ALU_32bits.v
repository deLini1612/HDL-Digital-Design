`timescale 1ps/1ps
module testbench_ALU_32bits;

    reg [31:0] test_a, test_b;
    wire [31:0] test_c;
    reg [2:0] test_op;

    ALU_32bits duv (
        .a(test_a),
        .b(test_b),
        .opcode(test_op),
        .c(test_c)
    );

    // Generate input randomly
    initial begin
        repeat (1000) begin
            test_a = $random;
            test_b = $random;
            test_op = $random;
            #1;
        end
    end

    // Generate golden output
    wire [31:0] golden_out;
    assign golden_out = (test_op==0) ? (test_a + test_b):
            (test_op==1) ? (test_a - test_b):
            (test_op==2) ? (~test_a):
            (test_op==3) ? (test_a & test_b):
            (test_op==4) ? (test_a | test_b):
            (test_op==5) ? (test_a ^ test_b):
            (test_op==6) ? (test_a <<< 1):
            (test_op==7) ? (test_a >>> 1):
            32'b0;

    // Compare and warn if different
    initial begin
        if (golden_out!=test_c) begin
           $monitor("[%0t] Error: golden_out = %d, test_c = %d",
                $time, golden_out, test_c); 
        end
        else begin
            $monitor("[%0t] Pass: golden_out = test_c = %d",
                $time, test_c);
        end
    end
endmodule
