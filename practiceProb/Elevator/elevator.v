module elevator #(
    parameter TIME = 4,
    parameter n = 10        //number of floors
) (
    input clk, rst_n,
    input [n-1:0] button_out; // nut yeu cau di len/xuong ngoai thang may
    input [n-1:0] button_in;  // nut chon tang ben trong thang may
    output open, close_n, up, down,   //cac nut dieu khien dong, mo, di len, di xuong
    output [n-1:0] current_floor
);
    datapath #(.n(n)) dp
    (
        .clk(clk),
        .rst_n(rst_n),
        .open(open),
        .up(up),
        .down(down),
        .button_out(button_out),
        .button_in(button_in),
        .request_i(request_i),
        .request_j_gt_i(request_j_gt_i),
        .request_j_lt_i(request_j_lt_i),
        .i(current_floor)
    );

    open_close_door #(.TIME(TIME)) open_close
    (
        .clk(clk),
        .rst_n(rst_n),
        .open(open),
        .close_n(close_n)
    );

    control mainFSM
    (
        .clk(clk),
        .rst_n(rst_n),
        .request_i(request_i),
        .request_j_gt_i(request_j_gt_i),
        .request_j_lt_i(request_j_lt_i),
        .open(open),
        .close_n(close_n),
        .up(up),
        .down(down)
    );
endmodule