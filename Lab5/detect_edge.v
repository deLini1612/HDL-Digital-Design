// Module to detect edge (rising or falling) at input port
module detect_edge (
    input clk, rst_n,
    input in,
    output reg change
);

    localparam [1:0]    idle = 0,
                        zero = 1,
                        one = 2;

    reg [1:0] state, next_state;

    //state register
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= idle;
        else state <= next_state;
    end

    //next-state logic and output logic
    always @(in or state) begin
        next_state = state;
        change = 0;
        case (state)
            idle : begin
                if(in) next_state = one;
                if(~in) next_state = zero;
            end

            zero : if(in) begin
                change = 1;
                next_state = one;
            end
        
            one: if(~in) begin
                change = 1; 
                next_state = zero;
            end

            default: next_state = zero;
        endcase
    end 
endmodule