module Rx_control (
    input clk, rst_n, bit_begin,
    input i_eq_10, t_eq_sym_wid, t_eq_hal_sym_wid,
    output reg get, inc_i, inc_t, reset_i, reset_t, done,
    output reg recv_req     // always = 1; =0 if receiving
);

    // state encoding
    localparam  idle = 0,
                receiving = 1;

	reg state, next_state;

    //next-state logic and output logic
	always @(state, i_eq_10, t_eq_sym_wid, t_eq_hal_sym_wid, bit_begin)
	begin
        get = 0;
        inc_i = 0;
        inc_t = 0;
        reset_i = 0;
        reset_t = 0;
        recv_req = 1;
        done = 0;
        next_state = state;
		case (state)
            idle: 
                if (bit_begin) begin
                    reset_i = 1;
                    reset_t = 1;
                    recv_req = 0;
                    next_state = receiving;
                end

            receiving:
            begin
                recv_req = 0;
                if (bit_begin|t_eq_sym_wid) begin
                    reset_t = 1;
                    inc_i = 1;
                    if (i_eq_10) begin
                        reset_i = 1;
                        done = 1;
                        next_state = idle;
                    end
                end
                else begin
                    inc_t = 1;
                    if (t_eq_hal_sym_wid) get = 1;
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