/* =====================CONTROL MODULE=====================
Module to control the behavior of a n-floor elevator */

module control (
    input clk, rst_n,       //clock and active low reset signal
    input request_i,        //input from datapath: = 1 if has request at floor i (i is current floor)
    input request_j_gt_i,   //input from datapath: = 1 if has request at floor j > i (i is current floor)
    input request_j_lt_i,   //input from datapath: = 1 if has request at floor j < i (i is current floor)
    output open,            //open door control
    input close,          //state the elevator is close (control by submodule open_close_door)
    output reg up, down         //state elevator goes or down
);
	localparam  s_stop  = 0,    //State that elevator stops
                s_up    = 1,    //State that elevator goes up
                s_down = 2;     //State that elevator goes down

	reg [1:0] state, next_state;

    //next-state logic and output logic
	always @(state, request_i, request_j_gt_i, request_j_lt_i, close)
	begin
		up = 0;
		down = 0;
		next_state = state;
        if (close & (~open)) begin

		case (state)

		s_stop: begin 
				if (request_j_gt_i) begin
					up = 1;
					next_state = s_up;
				end
				else if (request_j_lt_i) begin
					down = 1;
					next_state = s_down;
				end
			end 

		s_up: begin 
				if (request_j_gt_i) begin
					up = 1;
					next_state = s_up;
				end
				else begin
					next_state = s_stop;
				end
		end

		s_down: begin
				if (request_j_lt_i) begin
					down = 1;
					next_state = s_down;
				end
				else begin
					next_state = s_stop;
				end
		end

		default: next_state=s_stop;
		endcase
        end 
	end

	assign open = request_i & close;

    //state register
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
		    state <= s_stop;
		end
		else begin
			state <= next_state;
		end
	end

endmodule