module open_close_door #(
    parameter TIME = 4      //open door and wait TIME (s) until close door
) (
    input clk, rst_n,
    input open,
    output reg close_n
);

    reg [$clog2(TIME+1) -1 :0] timer, next_timer;
    reg done;   //done 1 time open and close

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            close_n <= 1;
            timer <= 0;
            done <= 0;        
        end
        else
            timer <= next_timer; 
    end
    
    always @(open or timer) begin
        next_timer = 0;
        if (open) begin     //start count
            timer = 0;
            close_n = 1;
            done = 0;
        end
        else if (~done) begin
            if (timer == TIME) begin  //done
                next_timer = 0;
                done = 1;
                close_n = 1;
            end
            else begin //openning and count
                next_timer = timer +1;
                close_n = 0;
                done = 0;
            end
        end
    end

endmodule