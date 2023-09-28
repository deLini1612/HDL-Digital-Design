module debouncer #(
    parameter LATENCY = 4
) (
    input       clk,
    input       rst_n,
    input       signal_in,
    output reg  debouned_signal
);

    localparam SHIFT_REG_WIDtH = LATENCY - 1;
    
    reg [SHIFT_REG_WIDtH - 1:0] input_shift_reg;
    wire                        output_set;
    wire                        output_clr;

    always @(posedge clk or rst_n) begin
        if (~rst_n) begin
            input_shift_reg <= {(SHIFT_REG_WIDtH){1'b1}};
        end
        else begin
            input_shift_reg <= {input_shift_reg[SHIFT_REG_WIDtH - 2 : 0], signal_in};
        end
    end

    assign output_clr = ~(|input_shift_reg[SHIFT_REG_WIDtH - 1:0]);
    assign output_set = &input_shift_reg[SHIFT_REG_WIDtH - 1:0];

    always @(posedge clk or rst_n) begin
        if (~rst_n) begin
            debouned_signal <= 1;
        end
        else begin
            if (output_clr) debouned_signal <= 0;
            else if (output_set) debouned_signal <= 1;
        end
    end
endmodule