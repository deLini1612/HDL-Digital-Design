//module to detect and generate a one clock cycle tick
//when input signal changes from 0 to 1 (rising edge)
//this file contains 3 approachs: moore fsm, mealy fsm and direct implementation

//COMPARISON: Mealy FSM requires fewer states amd responds faster 
//            but the width of its output may vary and input glitches may be passed to the output


//moore fsm
module rising_edge_moore (
    input clk, rst_n,   //clock and reset active low
    input in,           // input
    output reg tick
);

    localparam  zero = 2'b00, //input stay low for a while
                edg = 2'b01,  //there's a rising edge
                one = 2'b10;  //input stay high for a while

    reg [1:0] state, next_state;

    //state register
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= zero;
        else state <= next_state;
    end

    //next-state logic and output logic
    always @(in or state) begin
        next_state = state;
        tick = 0;
        case (state)
            zero: if(in) next_state = edg;
            
            edg: begin
                if(in) next_state = one;
                else next_state = zero;
                tick = 1; 
            end

            one: if(~in) next_state = zero;
            default: next_state = zero;
        endcase
    end
endmodule

//mealy fsm
module rising_edge_mealy (
    input clk, rst_n,
    input in,
    output reg tick
);

    localparam  zero = 0,
                one = 1;

    reg state, next_state;

    //state register
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= zero;
        else state <= next_state;
    end

    //next-state logic and output logic
    always @(in or state) begin
        next_state = state;
        tick = 0;
        case (state)
            zero : if(in) begin
                tick = 1;
                next_state = one;
            end
        
            one: if(~in) next_state = zero;
            default: next_state = zero;
        endcase
    end 
endmodule

//direct implementation using 1 FF and 1 NOT, 1 AND
module rising_edge_direct (
    input clk, rst_n,
    input in,
    output tick
);

    //declare delay_reg signal (output of FF)
    reg delay_reg;

    //FF
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) delay_reg <= 0;
        else delay_reg <= in;
    end

    assign tick = (~delay_reg) & in;
endmodule