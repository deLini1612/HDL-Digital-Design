module highway (
    input clk, glob_rst_n,
    input car,                  // signal detect car on country street
    input enable_h,             // enable highway
    input t_timeout, T_timeout, // timeout signal
    output reg enable_c,        // enable country
    output reg start_t, start_T,// start timer count t(s) and T(s)
    output [6:0] led_highway    // 7-seg led: 0 = green, 1 = yellow, 2 = red
);

    localparam  green = 2'b00,  // led highway is green
                yellow  = 2'b01,   // led highway is red
                red = 2'b10; // led highway is yellow

    reg [1:0] state, next_state;

    //state register
    always @(posedge clk or negedge glob_rst_n) begin
        if (~glob_rst_n) state <= green;
        else state <= next_state;
    end

    //next-state logic and output logic
    always @(state or car or t_timeout or T_timeout or enable_h) begin
        // default
        next_state = state;
        start_t = 0;
        start_T = 0;
        enable_c = 0;

        case (state)
            green:
                if ((~car)&(~T_timeout)) start_T = 1;
                else if (car & T_timeout) begin
                    start_t = 1;
                    next_state = yellow;
                end

            yellow:
                if (t_timeout) begin
                    enable_c = 1;
                    next_state = red;
                end

            red:
                if (enable_h) begin
                    start_T = 1;
                    next_state = green;
                end

            default: next_state = green;
        endcase
    end

    assign led_highway =    (state == 0) ? 7'b0000001:
                            (state == 1) ? 7'b1001111:
                            (state == 2) ? 7'b0010010:
                            7'b1111111;
endmodule