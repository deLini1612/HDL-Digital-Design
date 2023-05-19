// module to divide binary number to a constant
module div #(
    parameter WIDTH_DIVIDEND,   //width of dividend
    parameter WIDTH_DIVISOR     //width of divisor
) (
    input [WIDTH_DIVIDEND-1:0] a, // dividend
    input [WIDTH_DIVISOR-1:0] b, //divisor
    output reg [WIDTH_DIVIDEND - WIDTH_DIVISOR:0] res, //max length of res is len(a) - len(b) + 1
    output [WIDTH_DIVISOR-1:0] mod //max length of remainder is len(b)
);

    reg [WIDTH_DIVISOR:0] widen, widen_next;
    reg [WIDTH_DIVIDEND-1:0] a_copy;

    initial begin
        widen = 0;
        a_copy = a;
        res = 0;
    end

    always @(a or b) begin
        widen = {1'b0, a[WIDTH_DIVIDEND-1: WIDTH_DIVIDEND-WIDTH_DIVISOR]};
        a_copy = {a[WIDTH_DIVIDEND-WIDTH_DIVISOR-1:0], {WIDTH_DIVISOR{1'b0}}};
        res = 0;
        repeat (WIDTH_DIVIDEND - WIDTH_DIVISOR) begin
            if (widen >= b) begin
                widen_next = widen - b;
                res[0] = 1'b1;
            end
            else widen_next = widen;
            {widen, a_copy, res} = {widen_next, a_copy, res} << 1;
        end
        if (widen >= b) begin
            widen_next = widen - b;
            res[0] = 1'b1;
        end
        else widen_next = widen;
        widen = widen_next;       
    end

    assign mod = widen[WIDTH_DIVISOR-1:0];

endmodule