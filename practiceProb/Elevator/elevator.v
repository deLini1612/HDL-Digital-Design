module elevator #(
    parameter TIME = 3,
    parameter WIDTH = 2,
    parameter n = 10        //number of floors
) (
    input clk, rst_n,
    input [n-1:0] button_out, // nut yeu cau di len/xuong ngoai thang may
    input [n-1:0] button_in,  // nut chon tang ben trong thang may
    output open, close, up, down,   //cac nut dieu khien dong, mo, di len, di xuong
    output [n-1:0] current_floor,
    output [n-1:0] request
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
        .i(current_floor),
        .request(request)
    );

    open_close_door #(.TIME(TIME), .WIDTH(WIDTH)) open_close
    (
        .clk(clk),
        .rst_n(rst_n),
        .open(open),
        .close(close)
    );

    control mainFSM
    (
        .clk(clk),
        .rst_n(rst_n),
        .request_i(request_i),
        .request_j_gt_i(request_j_gt_i),
        .request_j_lt_i(request_j_lt_i),
        .open(open),
        .close(close),
        .up(up),
        .down(down)
    );

endmodule