//top_module for a 4_th floor and wait 2 sec

module elevator_topmodule (
    input built_in_clk, rst_n,
    input [3:0] button_out, // nut yeu cau di len/xuong ngoai thang may
    input [3:0] button_in,  // nut chon tang ben trong thang may
    output close, up, down,   //cac nut dieu khien dong, mo, di len, di xuong
    output [6:0] BCD_current
);
    wire open;
    wire [4:0] current_floor;
    wire clk;
    
    // Generate clk 1Hz
    clk_1Hz clk1hz(
        .built_in_clk(built_in_clk),
        .clk(clk)
    );

    elevator #(.TIME(3), .n(4), .WIDTH(2)) elevator_5th_floor 
    (
        .clk(clk),
        .rst_n(rst_n),
        .button_out(button_out),
        .button_in(button_in),
        .open(open),
        .close(close),
        .up(up),
        .down(down),
        .current_floor(current_floor)
    );

    display current_floor_display
    (
        .one_hot(current_floor),
        .seg(BCD_current)
    );
endmodule