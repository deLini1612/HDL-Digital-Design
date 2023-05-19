module day_rst (
    input [13:0] year,
    input [3:0] mon,
    output reg [5:0] nod //number of day
);
    wire divide_by_4, divide_by_400, is_leap;
    wire [6:0] temp100;
    wire [8:0] temp400;

    div #(.WIDTH_DIVIDEND(14), .WIDTH_DIVISOR(7)) div100 (
        .a(year),
        .b(100),
        .mod(temp100)
    );
    div #(.WIDTH_DIVIDEND(14), .WIDTH_DIVISOR(9)) div400 (
        .a(year),
        .b(400),
        .mod(temp400)
    );
    
    assign divide_by_4 = ~(year[1]|year[0]);
    assign divide_by_100 = (temp100==0)?1:0;
    assign divide_by_400 = (temp400==0)?1:0;
    assign is_leap = (divide_by_4&(~divide_by_100)) | divide_by_400;

    always @(year or mon or is_leap) begin
        case (mon)
            2 : nod = (is_leap==1)?30:29;
            4 : nod = 31; // thang 4
            6 : nod = 31; // thang 6
            9 : nod = 31; //thang 9
            11 : nod = 31; //thang 11
            default: nod = 32;
        endcase
    end
endmodule