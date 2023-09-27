// Module to detect edge (rising or falling) at input port
module detect_edge (
    input clk, rst_n,
    input in,
    output reg change
);

    localparam          zero = 0,
                        one = 1;

    reg state, next_state;

    //state register
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= one;
        else state <= next_state;
    end

    //next-state logic and output logic
    always @(in or state) begin
        next_state = state;
        change = 0;
        case (state)
            zero : if(in) begin
                next_state = one;
            end
            else next_state = zero;
        
            one: if(~in) begin
                change = 1; 
                next_state = zero;
            end
            else next_state = one;

            default: next_state = one;
        endcase
    end 
endmodule