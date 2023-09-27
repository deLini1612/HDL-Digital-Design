// Tx of UART
module Rx 
# (
    parameter SAMPLE = 16
)(
    input               clk,
    input               rst_n,
    input               enable,
    input               Rx,
    output  [7:0]       d_out,
    output              d_out_valid,    // = 1: d_out is valid
    output              parity_err,
    output              frame_err
);

    localparam FRAME_SIZE = 11;
    
    // signal declaration
    reg                                 state, next_state;
    reg [FRAME_SIZE - 1:0]              rx_buff_reg;
    reg [$clog2(FRAME_SIZE+1) -1: 0]    count_bit_val;
    reg                                 frame_done;
    reg                                 save_bit;
    reg                                 count_bit_en;
    reg                                 clk_div_clr;
    wire                                sample_tick;
    wire                                temp_parity_err;
    wire                                bit_begin;
    
    //=========================SAMPLE TICK GEN=========================
    clk_div #(
        .DIV_VAL(SAMPLE),
        .DIV_POS(SAMPLE/2 -1)
    ) sym_bit_gen (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .tick(sample_tick),
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
            if (count_bit_en && sample_tick) begin
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

    //=========================ERROR FLAG=========================
    assign temp_parity_err = ((^rx_buff_reg[9:2])==rx_buff_reg[1])?0:1;
    assign parity_err = frame_done & temp_parity_err;
    assign frame_err = frame_done & (~rx_buff_reg[0]);
    //assign d_out_valid = frame_done & (~temp_parity_err) & (~rx_buff_reg[0])
    assign d_out_valid = frame_done;
    //===============================================================

    //=========================BIT BEGIN=========================
    detect_edge detect (
        .clk(clk), .rst_n(rst_n),
        .in(Rx),
        .change(bit_begin)
    );
    //===============================================================

    //=========================CONTROL FSM=========================
    // state encoding
    localparam  IDLE = 2'b0,
                RECEIVING = 2'b1;

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
	always @(state, sample_tick, frame_done, bit_begin, enable)
	begin
        count_bit_en = 0;
        clk_div_clr = 0;
        save_bit = 0;
		case (state)
            IDLE:
            begin
                count_bit_en = 0;
                clk_div_clr = 1;
                save_bit = 0;

                if (bit_begin) next_state = RECEIVING;
                else next_state = IDLE;
            end

            RECEIVING:
            begin
                count_bit_en = 1;
                clk_div_clr = 0;
                save_bit = sample_tick;
                
                if (frame_done) next_state = IDLE;
                else next_state = RECEIVING;
            end

            default: next_state = state;
        endcase
	end
    //===============================================================

    //====================DATAPATH: RX BUFFER REG====================
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            rx_buff_reg <= {(FRAME_SIZE){1'b1}};
        end
        else begin
            if (save_bit) begin
                rx_buff_reg <= {rx_buff_reg[FRAME_SIZE - 2:0], Rx};
            end
            else rx_buff_reg <= rx_buff_reg;
        end
    end

    assign d_out = rx_buff_reg[FRAME_SIZE-2:2];
    //===============================================================


endmodule