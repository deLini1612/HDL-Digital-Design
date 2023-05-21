// Count and display 4 digits for year
module cnt_dis_year (
    input clk, glob_rst_n, ce,
    output is_leap,
    output [6:0] seg3, seg2, seg1, seg0
);
    reg [3:0] cnt3, cnt2, cnt1, cnt0;

    always @(posedge clk or negedge glob_rst_n) begin
        if (~glob_rst_n) begin cnt0 <= 0; cnt1 <= 0; cnt2 <= 0; cnt3 <= 0;
        end
        else 
            if (ce) begin
                if (cnt0 < 9) cnt0 <= cnt0+1;
                else begin
                    cnt0 <= 0;
                    if (cnt1 < 9) cnt1 <= cnt1 +1;
                    else begin
                        cnt1 <= 0;
                        if (cnt2 < 9) cnt2 <= cnt2 +1;
                        else begin
                            cnt2 <= 0;
                            if (cnt3 < 9) cnt3 <= cnt3 +1;
                            else begin
                                cnt3 <= 0;
                            end
                        end
                    end
                end
            end
            else begin
                cnt0 <= cnt0;
            end
    end    

    seg_year disyear(
        .seg0(seg0),
        .seg1(seg1),
        .seg2(seg2),
        .seg3(seg3),
        .cnt0(cnt0),
        .cnt1(cnt1),
        .cnt2(cnt2),
        .cnt3(cnt3)
    );

    wire divide_by_4, divide_by_100, divide_by_400;
    assign divide_by_4 = (cnt1[0]&cnt0[1]&(~cnt0[0]))|((~cnt1[0])&(~cnt0[1])&(~cnt0[0]));
    assign divide_by_100 = (~cnt0[1])&(~cnt0[0]);
    assign divide_by_400 = divide_by_100&((cnt3[0]&cnt2[1]&(~cnt2[0]))|((~cnt3[0])&(~cnt2[1])&(~cnt2[0])));
    assign is_leap = (divide_by_4&(~divide_by_100)) | divide_by_400;
endmodule