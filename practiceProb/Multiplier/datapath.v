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

always @(posedge clk or negedge rst_n) begin
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
