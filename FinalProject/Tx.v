// Tx of UART
module Tx 
# (
    parameter SAMPLE = 16
)(
    input               clk,
    input               rst_n,
    input               enable,
    input       [7:0]   d_in,
    input               send_req,
    output reg          tx_ready,   // = 1: transmitter is available
    output              Tx
);

    localparam FRAME_SIZE = 11;
    
    // signal declaration
    reg [1:0]                           state, next_state;
    reg [FRAME_SIZE - 1:0]              tx_shift_reg;
    reg [$clog2(FRAME_SIZE+1) -1: 0]    count_bit_val;
    reg                                 stop_bit;
    reg                                 load_tx_shift_reg;
    reg                                 shift;
    reg                                 count_bit_en;
    reg                                 clk_div_clr;
    wire                                sym_tick;
    wire                                parity_val;
    
    // state encoding
    localparam  IDLE = 2'b00,
                SET_UP = 2'b01,
                SENDING = 2'b10,
                STOP = 2'b11;
    //=========================SYMBOL TICK GEN=========================
    clk_div #(
        .DIV_VAL(SAMPLE),
        .DIV_POS(SAMPLE/2 -1)
    ) sym_bit_gen (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .tick(sym_tick),
        .clear(clk_div_clr)
    );
    //===============================================================

    //=========================COUNT FRAME BIT=========================
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            count_bit_val <= 0;
            stop_bit <= 0;
        end
        else begin
		    if (state == SET_UP) begin
                count_bit_val <= 0;
                stop_bit <= 0;
            end
            else if (count_bit_en && sym_tick) begin
                if (count_bit_val == FRAME_SIZE -2) begin
                    count_bit_val <= count_bit_val + 1;
                    stop_bit <= 1;                   
                end
                else if (count_bit_val == FRAME_SIZE -1) begin
                    count_bit_val <= 0;
                    stop_bit <= 0;
                end
                else begin
                    count_bit_val <= count_bit_val + 1;
                    stop_bit <= 0;
                end
            end
            else begin
                count_bit_val <= count_bit_val;
                stop_bit <= 0;
            end
        end
    end
    //===============================================================

    //=========================CAL PARITY=========================
    assign parity_val = ^d_in[7:0];
    //===============================================================

    //=========================CONTROL FSM=========================


    // state register
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
		    state <= IDLE;
		end
		else begin
			state <= next_state;
		end
	end

    // next-state logic and output logic
	always @(state, send_req, sym_tick, stop_bit)
	begin
        load_tx_shift_reg = 0;
        tx_ready = 1;
        count_bit_en = 0;
        clk_div_clr = 0;
        shift = 0;
		case (state)
            IDLE:
            begin
                load_tx_shift_reg = 0;
                tx_ready = 1;
                count_bit_en = 0;
                clk_div_clr = 1;
                shift = 0;

                if (send_req) next_state = SET_UP;
                else next_state = IDLE;
            end

            SET_UP:
            begin
                load_tx_shift_reg = 1;
                tx_ready = 0;
                count_bit_en = 0;
                clk_div_clr = 0;
                shift = 0;

                if (sym_tick) next_state = SENDING;
                else next_state = SET_UP;
            end

            SENDING:
            begin
                load_tx_shift_reg = 0;
                tx_ready = 0;
                count_bit_en = 1;
                clk_div_clr = 0;
                shift = sym_tick;
                
                if (stop_bit) next_state = STOP;
                else next_state = SENDING;
            end

            STOP:
            begin
                load_tx_shift_reg = 0;
                tx_ready = 1;
                count_bit_en = 1;
                clk_div_clr = 1;
                shift = sym_tick;
                if (send_req) next_state = SET_UP;
                else if(sym_tick) next_state = IDLE;
                else next_state = STOP;
            end

            default: next_state = state;
        endcase
	end
    //===============================================================

    //====================DATAPATH: TX SHIFT REG====================
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            tx_shift_reg <= {(FRAME_SIZE){1'b1}};
        end
        else begin
            if (load_tx_shift_reg) begin
                tx_shift_reg <= {1'b0, d_in, parity_val, 1'b1};
            end
            else if (shift) begin
                tx_shift_reg <= {tx_shift_reg[9:0], 1'b1};
            end
        end
    end

    assign Tx = count_bit_en?tx_shift_reg[10]:1;
    //===============================================================


endmodule