module Tx_control (
    input clk, rst_n, send_req,
    input i_eq_10, t_eq_sym_wid,
    output reg load_bit, inc_i, inc_t, reset_i, reset_t,
    output reg send_ack     // always = 1; =0 if sending
);

    // state encoding
    localparam  idle = 0,
                sending = 1;

	reg state, next_state;

    //next-state logic and output logic
	always @(state, i_eq_10, t_eq_sym_wid, send_req)
	begin
        load_bit = 0;
        inc_i = 0;
        inc_t = 0;
        reset_i = 0;
        reset_t = 0;
        send_ack = 1;
        next_state = state;
		case (state)
            idle: 
                if (send_req) begin
                    reset_i = 1;
                    reset_t = 1;
                    load_bit = 1;
                    next_state = sending;
                end

            sending:
            begin
                send_ack = 0;
                if (~t_eq_sym_wid) begin
                    inc_t = 1;
                end
                else begin
                    inc_i = 1;
                    reset_t = 1;
                    if (i_eq_10) begin
                        reset_i = 1;
                        reset_t = 1;
                        next_state = idle;
                    end
                end
            end

            default: next_state = state;
        endcase
	end

    //state register
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
		    state <= idle;
		end
		else begin
			state <= next_state;
		end
	end

endmodule