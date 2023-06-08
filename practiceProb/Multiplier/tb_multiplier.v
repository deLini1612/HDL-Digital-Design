module tb_multiplier ();
    reg clk, rst_n;
    reg [7:0] sn, sbn;
    wire [15:0] tich;
    reg req;
    wire ack;
    
    multiplier #(.n(8)) duv
    (
        .clk(clk),
        .rst_n(rst_n),
        .sn(sn),
        .sbn(sbn),
        .req(req),
        .tich(tich),
        .ack(ack)
    );

    initial begin
        clk = 0;
        repeat(20020) #10 clk = ~clk;
    end
    
    initial begin
        rst_n = 0;
	    #30 rst_n = 1;
    end
    
    integer i;
    initial begin
        #50;
        repeat (1000)
        begin
            sn = $random;
            sbn = $random;
            #190;
            if (ack == 0) $display("[%0t] Fail: Khong co ack", $time);
            if (sn*sbn != tich) $display("[%0t] Fail: Khong dung tich", $time);
            #10;
        end
    end

    initial begin
        req = 0;
        #50 req = 1;
        repeat (1000) begin
            #20 req = 0;
            #180 req = 1;
        end
        req = 0;
    end
endmodule