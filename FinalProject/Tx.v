// Tx of UART
module Tx 
# (
    parameter SAMPLE = 16,
    parameter DATA_SIZE = 8,
    parameter STOP_SIZE = 1
)(
    input           clk,
    input           rst_n,
    input           enable,
    input   [7:0]   d_in,
    input           send_req,
    output          send_ack,   // = 1: transmitter is ready to transmit
    output          Tx
);

    localparam FRAME_SIZE = 1 + DATA_SIZE + STOP_SIZE + PARITY;

    // state encoding
    localparam  IDLE = 2'b00,
                CAL_PARITY = 2'b01,
                SENDING = 2'b10;
    
    // signal declaration
    reg [1:0]                           state, next_state;
    reg [FRAME_SIZE - 1:0]              tx_shift_reg;
    reg [$clog2(FRAME_SIZE+1) -1: 0]    bit_index;
    reg                                 frame_done;
    reg                                 load_data_in;
    reg                                 shift;
    
    //state register
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
		    state <= idle;
		end
		else begin
			state <= next_state;
		end
	end

    // next-state logic and output logic
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


endmodule