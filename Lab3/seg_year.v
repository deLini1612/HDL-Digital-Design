module seg_year (
    input [3:0] cnt3, cnt2, cnt1, cnt0,
    output [6:0] seg3, seg2, seg1, seg0
);
    BCD27seg csnghin(
        .bcd(cnt3),
        .seg(seg3)
    );

    BCD27seg cdtram(
        .bcd(cnt2),
        .seg(seg2)
    );

    BCD27seg cschuc(
        .bcd(cnt1),
        .seg(seg1)
    );

    BCD27seg csdv(
        .bcd(cnt0),
        .seg(seg0)
    );
endmodule