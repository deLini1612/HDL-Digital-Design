`timescale 1ps/1ps
module tb_day_rst ();
    reg [13:0] year;
    reg [3:0] mon;
    wire [5:0] nod;

    day_rst duv(
        .year(year),
        .mon(mon),
        .nod(nod)
    );

    // Generate full test input
    initial begin
        for (year = 0; year < 3001; year = year + 1) begin
            for (mon = 1; mon < 13; mon = mon + 1) begin
                #1;
            end
        end
    end

endmodule