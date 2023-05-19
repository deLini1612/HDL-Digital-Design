module timer (
    input clk, glob_rst_n,
    output [5:0] sec, min,
    output [4:0] hour, day,
    output [3:0] mon,
    output [13:0] year
);

    wire [4:0] carry_out;
    wire [5:0] nod;
    
    day_rst rst_day_val(
        .year(year),
        .mon(mon),
        .nod(nod)
    );

    counter #(.NUMBER_OF_BIT(6), .RST_INIT(0)) cnt_sec (
        .clk(clk),
        .ce(1),
        .glob_rst_n(glob_rst_n),
        .RST_VALUE(60),
        .cnt(sec),
        .carry_out(carry_out[0])
    );

    counter #(.NUMBER_OF_BIT(6), .RST_INIT(0)) cnt_min (
        .clk(clk),
        .ce(carry_out[0]),
        .glob_rst_n(glob_rst_n),
        .RST_VALUE(60),
        .cnt(min),
        .carry_out(carry_out[1])
    );

    counter #(.NUMBER_OF_BIT(5), .RST_INIT(0)) cnt_hour (
        .clk(clk),
        .ce(carry_out[1]),
        .glob_rst_n(glob_rst_n),
        .RST_VALUE(24),
        .cnt(hour),
        .carry_out(carry_out[2])
    );

    counter #(.NUMBER_OF_BIT(5), .RST_INIT(1)) cnt_day (
        .clk(clk),
        .ce(carry_out[2]),
        .glob_rst_n(glob_rst_n),
        .RST_VALUE(nod),
        .cnt(day),
        .carry_out(carry_out[3])
    );
    
    counter #(.NUMBER_OF_BIT(4), .RST_INIT(1)) cnt_mon (
        .clk(clk),
        .ce(carry_out[3]),
        .glob_rst_n(glob_rst_n),
        .RST_VALUE(13),
        .cnt(mon),
        .carry_out(carry_out[4])
    );

    counter #(.NUMBER_OF_BIT(14), .RST_INIT(0)) cnt_year (
        .clk(clk),
        .ce(carry_out[4]),
        .glob_rst_n(glob_rst_n),
        .RST_VALUE(10000),
        .cnt(year)
    );

endmodule