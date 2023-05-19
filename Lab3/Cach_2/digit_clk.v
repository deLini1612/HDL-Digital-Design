module digit_clk (
    input [5:0] sec, min,
    input [4:0] hour, day,
    input [3:0] mon,
    input [13:0] year,
    output [7:0] digit_sec, digit_min, digit_hour, digit_day, digit_mon,
    output [15:0] digit_year
);
    wire [4:0] year3_t;
    wire [10:0] year123;
    wire [7:0] year23;

    div #(.WIDTH_DIVIDEND(7), .WIDTH_DIVISOR(4)) sec_digit (
        .a({1'b0,sec}),
        .b(4'd10),
        .res(digit_sec[7:4]),
        .mod(digit_sec[3:0])
    );

    div #(.WIDTH_DIVIDEND(7), .WIDTH_DIVISOR(4)) min_digit (
        .a({1'b0,min}),
        .b(4'd10),
        .res(digit_min[7:4]),
        .mod(digit_min[3:0])
    );
    
    div #(.WIDTH_DIVIDEND(7), .WIDTH_DIVISOR(4)) hour_digit (
        .a({2'b0,hour}),
        .b(4'd10),
        .res(digit_hour[7:4]),
        .mod(digit_hour[3:0])
    );

    div #(.WIDTH_DIVIDEND(7), .WIDTH_DIVISOR(4)) day_digit (
        .a({2'b0,day}),
        .b(4'd10),
        .res(digit_day[7:4]),
        .mod(digit_day[3:0])
    );

    div #(.WIDTH_DIVIDEND(7), .WIDTH_DIVISOR(4)) mon_digit (
        .a({3'b0,mon}),
        .b(4'd10),
        .res(digit_mon[7:4]),
        .mod(digit_mon[3:0])
    );

    div #(.WIDTH_DIVIDEND(14), .WIDTH_DIVISOR(4)) year_digit0 (
        .a(year),
        .b(4'd10),
        .res(year123),
        .mod(digit_year[3:0])
    );

    div #(.WIDTH_DIVIDEND(11), .WIDTH_DIVISOR(4)) year_digit1 (
        .a(year123),
        .b(4'd10),
        .res(year23),
        .mod(digit_year[7:4])
    );

    div #(.WIDTH_DIVIDEND(8), .WIDTH_DIVISOR(4)) year_digit23 (
        .a({2'b0,year}),
        .b(4'd10),
        .res(year3_t), //5digit
        .mod(digit_year[11:8])
    );

    assign digit_year[15:12] = year3_t[3:0];

endmodule