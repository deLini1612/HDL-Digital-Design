// Tx of UART
module Tx_old 
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
    reg                                 frame_done;
    reg                                 load_tx_shift_reg;
    reg                                 shift;
    reg                                 count_bit_en;
    reg                                 clk_div_clr;
    wire                                sym_tick;
    wire                                parity_val;
    
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
            frame_done <= 0;
        end
        else begin
            if (count_bit_en && sym_tick) begin
                if (count_bit_val == FRAME_SIZE -1) begin
                    count_bit_val <= 0;
                    frame_done <= 1;
                end
                else begin
                    count_bit_val <= count_bit_val + 1;
                    frame_done <= 0;
                end
            end
            else begin
                count_bit_val <= count_bit_val;
                frame_done <= 0;
            end
        end
    end
    //===============================================================

    //=========================CAL PARITY=========================
    assign parity_val = ^d_in[7:0];
    //===============================================================

    //=========================CONTROL FSM=========================
    // state encoding
    localparam  IDLE = 2'b00,
                SET_UP = 2'b01,
                SENDING = 2'b10;

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
	always @(state, send_req, sym_tick, frame_done)
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
                
                if (frame_done) next_state = IDLE;
                else next_state = SENDING;
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