module country (
    input clk, glob_rst_n,
    input enable_c,             // enable highway
    input t_timeout, T_timeout, // timeout signal
    output reg enable_h,        // enable country
    output reg start_t, start_T,// start timer count t(s) and T(s)
    output [6:0] led_country
);

    localparam  green = 2'b00,  // led highway is green
                yellow  = 2'b01,   // led highway is red
                red = 2'b10; // led highway is yellow

    reg [1:0] state, next_state;

    //state register
    always @(posedge clk or negedge glob_rst_n) begin
        if (~glob_rst_n) state <= red;
        else state <= next_state;
    end

    //next-state logic and output logic
    always @(state or t_timeout or T_timeout or enable_c) begin
        // default
        next_state = state;
        start_t = 0;
        start_T = 0;
        enable_h = 0;

        case (state)
            green:
                if (T_timeout) begin
                    start_t = 1;
                    next_state = yellow;
                end

            yellow:
                if (t_timeout) begin
                    enable_h = 1;
                    next_state = red;
                end

            red:
                if (enable_c) begin
                    start_T = 1;
                    next_state = green;
                end

            default: next_state = red;
        endcase
    end

    assign led_country =    (state == 0) ? 7'b0000001:
                            (state == 1) ? 7'b1001111:
                            (state == 2) ? 7'b0010010:
                            7'b1111111;
endmodule