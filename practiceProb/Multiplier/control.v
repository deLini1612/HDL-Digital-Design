
module control #(parameter n = 8) (
    // dieu khien khoi datapath thuc hien phep toan theo thu tu
    input clk, rst_n,
    input req, cnt_eq_0,
    input b0,
    output reg add, shift, ack, load
);

    localparam  idle = 1'b0,
                computing = 1'b1;

    reg next_state, state;
    always @(state, req, b0, cnt_eq_0) begin
        add = 0;
        shift = 0;
        ack = 0;
        load = 0;
        next_state = state;

        if (state == idle)
        begin
            if (req) begin
                next_state = computing;
                load = 1;
            end
        end
        else
        begin
            if (cnt_eq_0) begin
                next_state = idle;
                ack = 1;
            end
            else begin
                if (b0) add = 1;
                shift = 1;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= idle;
        else state <= next_state;
    end
    
endmodule