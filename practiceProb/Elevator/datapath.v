module datapath #(
    parameter n = 10         //number of floors
) (
    input clk, rst_n,
    input open,
    input up, down,                     // signal open from control module
    input [n-1:0] button_out,        // nut yeu cau di len/xuong ngoai thang may
    input [n-1:0] button_in,        // nut chon tang ben trong thang may
    output request_i,               // = 1 if has request at floor i (i is current floor)
    output request_j_gt_i,          // = 1 if has request at floor j > i (i is current floor)
    output request_j_lt_i,          // = 1 if has request at floor j < i (i is current floor)
    output reg [n-1:0] i                // current floor one-hot encode
);

    reg [n-1:0] request, next_request;

    // determine request -> not clk
    always @(button_out or button_in or open) begin
        if (open) begin
            //has open signal -> clear request at current (i-th) floor -> and ~(i)
            next_request = (request | (~button_in) |  (~button_out)) & (~i);
        end
        // has request signal -> set the coresponding bit -> or with signal
        else next_request = request | (~button_in) |  (~button_out);
    end


	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			i <= 1;
            request <= 0;
		end
		else begin
            request <= next_request;
			if (up) if (i[n-1]==0) i <= (i<<1);
			else if (down) if (i[0]!=1) i <= (i>>1);
		end
	end

    assign request_i = ~((i & request)==0);
	assign request_j_gt_i = (request & ~i) > i;
	assign request_j_lt_i = (~request_i) & (~request_j_gt_i) & ~(request == 0) ;
endmodule