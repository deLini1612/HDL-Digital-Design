module display_clk (
    input [7:0] digit_sec, digit_min, digit_hour, digit_day, digit_mon,
    input [15:0] digit_year,
    output [6:0] s_sec0, s_sec1,
    output [6:0] s_min0, s_min1,
    output [6:0] s_hour0, s_hour1,
    output [6:0] s_day0, s_day1,
    output [6:0] s_mon0, s_mon1,
    output [6:0] s_year0, s_year1, s_year2, s_year3
);

    BCD27seg sec0(
        .bcd(digit_sec[3:0]),
        .seg(s_sec0)
    );
    BCD27seg sec1(
        .bcd(digit_sec[7:4]),
        .seg(s_sec1)
    );

    BCD27seg min0(
        .bcd(digit_min[3:0]),
        .seg(s_min0)
    );
    BCD27seg min1(
        .bcd(digit_min[7:4]),
        .seg(s_min1)
    );

    BCD27seg hour0(
        .bcd(digit_hour[3:0]),
        .seg(s_hour0)
    );
    BCD27seg hour1(
        .bcd(digit_hour[7:4]),
        .seg(s_hour1)
    );

    BCD27seg day0(
        .bcd(digit_day[3:0]),
        .seg(s_day0)
    );
    BCD27seg day1(
        .bcd(digit_day[7:4]),
        .seg(s_day1)
    );

    BCD27seg mon0(
        .bcd(digit_mon[3:0]),
        .seg(s_mon0)
    );
    BCD27seg mon1(
        .bcd(digit_mon[7:4]),
        .seg(s_mon1)
    );

    BCD27seg year0(
        .bcd(digit_year[3:0]),
        .seg(s_year0)
    );
    BCD27seg year1(
        .bcd(digit_year[7:4]),
        .seg(s_year1)
    );
    BCD27seg year2(
        .bcd(digit_year[11:8]),
        .seg(s_year2)
    );
    BCD27seg year3(
        .bcd(digit_year[15:12]),
        .seg(s_year3)
    );

endmodule