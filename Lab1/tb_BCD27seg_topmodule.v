`timescale 1ps/1ps
module testbench_BCD27seg_topmodule ();
    reg [3:0] x0, x1, x2, x3;
    wire [6:0] seg0, seg1, seg2, seg3;

    BCD27seg_topmodule duv(
        .x0(x0),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .seg0(seg0),
        .seg1(seg1),
        .seg2(seg2),
        .seg3(seg3)
    );

    // Generate input randomly
    initial begin
        repeat (200) begin
            x0 = $random;
            x1 = $random;
            x2 = $random;
            x3 = $random;
            #1;
        end
    end

endmodule