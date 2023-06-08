module elevator #(
    parameter n = 10
) (
    input [n-1:0] button_up,        // nut yeu cau di len ngoai thang may
    input [n-1:0] button_down,      // nut yeu cau di xuong ngoai thang may
    input [n-1:0] button_floor, // nut chon tang ben trong thang may
    output open, close, go_up, go_down, //cac nut dieu khien dong, mo, di len, di xuong
    output [$clog2(n)-1:0] floor_number
);
    datapath #(.n(n)) dp
    (
        .clk(clk),
        .rst_n(rst_n),
        .button_up(button_up),
        .button_down(button_down),
        .button_floor(button_floor),
        .up(up),
        .down(down),
        .request_i(request_i),
        .request_j_gt_i(request_j_gt_i),
        .request_j_lt_i(request_j_lt_i)
    );

    control mainFSM
    (
        .clk(clk),
        .rst_n(rst_n),
        .close(close),
        .open(open),
        .up(up),
        .down(down),
        .request_i(request_i),
        .request_j_gt_i(request_j_gt_i),
        .request_j_lt_i(request_j_lt_i)
    );
endmodule

module control (
    //ports
);
    
    localparam  s_stop = 0,
                s_up = 1,
                s_down = 2;

    reg [1:0] state, nstate;

    always @(state, request_i, request_j_gt_i, request_j_lt_i) begin
        
    end
endmodule