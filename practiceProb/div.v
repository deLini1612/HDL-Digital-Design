// module to divide 2 number: a/b (quotation is res and the remaining is mod)
module div #(
    parameter WIDTH   //width of divisor and dividend
) (
    input clk,
    input [WIDTH-1:0] a, //dividend
    input [WIDTH-1:0] b, //divisor
    input start,                 //control bit: start calculation
    output reg [WIDTH-1:0] res, //max length of res is len(a) - len(b) + 1
    output reg [WIDTH-1:0] mod, //max length of remainder is len(b)
    output reg cal,                  //control bit: doing calculation
    output reg done                  //control bit: done calculation
);

    reg [WIDTH:0] widen, widen_next;
    reg [WIDTH-1:0] a_copy, a_copy_next;
    reg [$clog2(WIDTH):0] cnt;//count iteration

    always @(widen or a_copy or a or b) begin
        if (widen >= {1'b0,b}) begin
                widen_next = widen - b;
                {widen_next, a_copy_next} = {widen_next[WIDTH-1:0], a_copy, 1'b1};
            end
            else {widen_next, a_copy_next} = {widen[WIDTH-1:0], a_copy,1'b0};
    end

    always @(posedge clk) begin
        done <= 0;
        if (start) begin    //initial calculation and value
            cnt <= 0;
            {widen, a_copy} <= {{WIDTH{1'b0}}, a, 1'b0};
            cal <= 1;
        end
        else if (cal) begin
            if (cnt == WIDTH-1) begin //done calculation
                cal <= 0;
                done <= 1;
                mod <= widen_next[WIDTH:1];
                res <= a_copy_next;
            end
            else begin
                cnt <= cnt+1;
                widen <= widen_next;
                a_copy = a_copy_next;
            end
        end
    end
endmodule