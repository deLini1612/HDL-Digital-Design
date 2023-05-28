module multiplier #( parameter n = 8)
(
    input clk, rst_n,
    input [n-1:0] sn, sbn,
    output [2*n-1:0] tich,
    input req,  // = 1 trong 1 chu ky de bao bat dau nhan
    output ack // = 1 trong 1 chu ky de bao ket thuc nhan
);

    wire cnt_eq_0, b0, add, shift, load;
    datapath #(.n(n)) dp(
        .clk(clk), .rst_n(rst_n),
        .sn(sn), .sbn(sbn),
        .add(add), .shift(shift),
        .cnt_eq_0(cnt_eq_0), .b0(b0),
        .tich(tich),
        .load(load)
    );

    control #(.n(n)) ctr(
        .clk(clk), .rst_n(rst_n),
        .req(req), .ack(ack),
        .add(add), .shift(shift),
        .cnt_eq_0(cnt_eq_0), .b0(b0),
        .load(load)
    );
    
endmodule

module datapath #(parameter n = 8) (
    input clk, rst_n,
    input [n-1:0] sn, sbn,
    input add, shift, load,
    output cnt_eq_0, b0,
    output reg [2*n-1:0] tich
);
reg [2*n-1:0] a;
reg [n-1:0] b;
reg [$clog2(n):0] cnt;
assign b0 = b[0];
assign cnt_eq_0 = (cnt == 0);

always @(posedge clk) begin
    if (~rst_n) begin
      //reset
      a <= 0;
      tich <= 0;
      b <= 0;
      cnt <= 0;
    end
    else begin
      if (load) begin
        a <= sbn;
        b <= sn;
        cnt <= n;
        tich <= 0;
      end
      else begin
        // vi dung non-blocking assignment
        // nen co the doi vi tri khoi if (shift) len truoc khoi if (add)
        if (add)
            tich <= tich + a;
        if (shift) begin
            b <= b >>1;
            a <= a <<1;
            cnt <= cnt -1;
        end       
      end
    end
end
    
endmodule

module control #(parameter n = 8) (
    // dieu khien khoi datapath thuc hien phep toan theo thu tu
    input clk, rst_n,
    input req, cnt_eq_0,
    input b0,
    output reg add, shift, ack, load
);

    localparam  idle = 1'b0,
                computing = 1'b1;

    reg next_state, state;
    always @(state, req, b0, cnt_eq_0) begin
        add = 0;
        shift = 0;
        ack = 0;
        load = 0;
        next_state = state;

        if (state == idle)
        begin
            if (req) begin
                next_state = computing;
                load = 1;
            end
        end
        else
        begin
            if (cnt_eq_0) begin
                next_state = idle;
                ack = 1;
            end
            else begin
                if (b0) add = 1;
                shift = 1;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) state <= idle;
        else state <= next_state;
    end
    
endmodule