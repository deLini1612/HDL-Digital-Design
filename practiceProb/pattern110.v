module pattern110 (
    input clk, rst_n,
    input x,
    output reg y
);

/* Trong FSM co 2 phan:
1. Combinational logic: Logic to hop --> dung always khong co dong ho (KHONG DUOC DUNG ALWAYS *)
    -> dau vao cua always la dau vao va state
    -> khoi always nay co nhiem vu tinh y va next state
2. Flip flop noi trang thai ke tiep voi trang thai hien tai
    - next_state noi vao D va state noi vao Q
    -> dung khoi always co clk
*/

//khai bao hang so local = localparam
localparam s0 = 2'b00; //may dang cho bit 1 dau tien
localparam s1 = 2'b01; //may dang cho bit 1 thu 2
localparam s2 = 2'b10; //may dang chay cho bit 0 cuoi cung
reg[1:0] state, next_states;
always @(x or state) begin
    y=0;
    case (state)
        s0: if (x==1) next_states = s1;
            else next_states = s0;

        s1: if (x==1) next_states = s2;
            else next_states = s0;
            
        s2: if (x==1) next_states = s2;
            else begin
                next_states = s0;
                y = 1;
            end
            
        default: next_states = s0;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= s0;
    end
    else begin
        state <= next_states;
    end
end
    
endmodule