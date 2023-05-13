`timescale 1ps/1ps
module testbench_majority_32bits ();
    reg [31:0] test_in;
    wire test_maj;

    majority_32bits duv(
        .in(test_in),
        .maj(test_maj)
    );

    // Generate input directly
    initial begin
        // Set input = b0000 0000 0000 0000 0000 0000 0000 0000
        // Answer should be 0
        test_in = 32'h0000_0000;
        #1
        if (test_maj != 0) 
            $monitor("[%0t] Error: input = %b, golden_maj = 0, maj = %b",
                    $time, test_in, test_maj);
        else $monitor("[%0t] Pass: input = %b, golden_maj = maj = %b",
                    $time, test_in, test_maj);
        
        // Set input = b1111 1111 1111 1111 1111 1111 1111 1111
        // Answer should be 1
        test_in = 32'hFFFF_FFFF;
        #1
        if (test_maj != 1) 
            $monitor("[%0t] Error: input = %b, golden_maj = 1, maj = %b",
                    $time, test_in, test_maj);
        else $monitor("[%0t] Pass: input = %b, golden_maj = maj = %b",
                    $time, test_in, test_maj);
        
        // Set input = b1111 0000 1111 0000 1111 0000 1111 0000
        // Answer should be 0
        test_in = 32'hF0F0_F0F0;
        #1
        if (test_maj != 0) 
            $monitor("[%0t] Error: input = %b, golden_maj = 0, maj = %b",
                    $time, test_in, test_maj);
        else $monitor("[%0t] Pass: input = %b, golden_maj = maj = %b",
                    $time, test_in, test_maj);
        
        // Set input = b1101 1100 1111 0000 1011 0101 1001 0000
        // Answer should be 0
        test_in = 32'hDCF0_B590;
        #1
        if (test_maj != 0) 
            $monitor("[%0t] Error: input = %b, golden_maj = 0, maj = %b",
                    $time, test_in, test_maj);
        else $monitor("[%0t] Pass: input = %b, golden_maj = maj = %b",
                    $time, test_in, test_maj);
        
        // Set input = b0111 0111 1011 0000 1101 0110 0111 1001
        // Answer should be 1
        test_in = 32'h77B0_D679;
        #1
        if (test_maj != 1) 
            $monitor("[%0t] Error: input = %b, golden_maj = 1, maj = %b",
                    $time, test_in, test_maj);
        else $monitor("[%0t] Pass: input = %b, golden_maj = maj = %b",
                    $time, test_in, test_maj);
        
        // Set input = b1101 0110 0000 1111 1110 0100 1110 0110
        // Answer should be 1
        test_in = 32'hD60F_E4E6;
        #1
        if (test_maj != 1) 
            $monitor("[%0t] Error: input = %b, golden_maj = 1, maj = %b",
                    $time, test_in, test_maj);
        else $monitor("[%0t] Pass: input = %b, golden_maj = maj = %b",
                    $time, test_in, test_maj);
        
        // Set input = b0011 1110 0110 1101 1111 0000 0000 0010
        // Answer should be 0
        test_in = 32'h3E6D_F002;
        #1
        if (test_maj != 0) 
            $monitor("[%0t] Error: input = %b, golden_maj = 0, maj = %b",
                    $time, test_in, test_maj);
        else $monitor("[%0t] Pass: input = %b, golden_maj = maj = %b",
                    $time, test_in, test_maj);
        
        // Set input = b1010 0100 1011 0011 1000 0100 1111 1101
        // Answer should be 1
        test_in = 32'hA4B3_84FD;
        #1
        if (test_maj != 1) 
            $monitor("[%0t] Error: input = %b, golden_maj = 1, maj = %b",
                    $time, test_in, test_maj);
        else $monitor("[%0t] Pass: input = %b, golden_maj = maj = %b",
                    $time, test_in, test_maj);

    end

endmodule