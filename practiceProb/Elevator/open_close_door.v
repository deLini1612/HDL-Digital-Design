module open_close_door #(
    parameter TIME,      //open door and wait TIME (s) until close door
    parameter WIDTH
) (
    input clk, rst_n,
    input open,
    output reg close
);

    reg [WIDTH -1 :0] timer, next_timer;
    reg done;   //done 1 time open and close
    reg openning;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            timer <= 0;       
        end
        else
            timer <= next_timer; 
    end
    
    always @(open or timer) begin
        next_timer = 0;
		done = 0;
        close = 0;
        if (open) begin     //start count
            next_timer = 0;
            close = 1;
            done = 0;
            openning = 1;
        end
        else if(openning) begin
            if (timer == TIME) begin  //done
                next_timer = 0;
                done = 1;
                close = 1;
                openning = 0;
            end
            else begin //openning and count
                next_timer = timer +1;
                close = 0;
                done = 0;
                openning = 1;
            end
        end
        else close = 1;
    end

endmodule