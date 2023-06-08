module multiplier #( parameter n = 8)
(
    input clk, rst_n,
    input [n-1:0] sn, sbn,
    output [2*n-1:0] tich,
    input req,  // = 1 trong 1 chu ky de bao bat dau nhan
    output ack // = 1 trong 1 chu ky de bao ket thuc nhan
);

    wire cnt_eq_0, b0, add, shift, load;
    datapath #(.n(n)) dp(
        .clk(clk), .rst_n(rst_n),
        .sn(sn), .sbn(sbn),
        .add(add), .shift(shift),
        .cnt_eq_0(cnt_eq_0), .b0(b0),
        .tich(tich),
        .load(load)
    );

    control #(.n(n)) ctr(
        .clk(clk), .rst_n(rst_n),
        .req(req), .ack(ack),
        .add(add), .shift(shift),
        .cnt_eq_0(cnt_eq_0), .b0(b0),
        .load(load)
    );
    
endmodule