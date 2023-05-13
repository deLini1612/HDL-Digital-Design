//---------------SPEC---------------
//  INPUT:  2 input a, b - 32 bits
//  OUTPUT: s - 32 bits represent sum of a and b
//          c - 1 bit represent carry of a + b
//----------------------------------

module CRA_8bits (
    input [7:0] a, b,
    output [7:0] s,
    output co
);
    wire [6:0] carry;
    Full_Adder FA1 (
        .a(a[0]),
        .b(b[0]),
        .ci(0),
        .s(s[0]),
        .co(carry[0])
    );
    Full_Adder FA2 (
        .a(a[1]),
        .b(b[1]),
        .ci(carry[0]),
        .s(s[1]),
        .co(carry[1])
    );
    Full_Adder FA3 (
        .a(a[2]),
        .b(b[2]),
        .ci(carry[1]),
        .s(s[2]),
        .co(carry[2])
    );
    Full_Adder FA4 (
        .a(a[3]),
        .b(b[3]),
        .ci(carry[2]),
        .s(s[3]),
        .co(carry[3])
    );
    Full_Adder FA5 (
        .a(a[4]),
        .b(b[4]),
        .ci(carry[3]),
        .s(s[4]),
        .co(carry[4])
    );
    Full_Adder FA6 (
        .a(a[5]),
        .b(b[5]),
        .ci(carry[4]),
        .s(s[5]),
        .co(carry[5])
    );
    Full_Adder FA7 (
        .a(a[6]),
        .b(b[6]),
        .ci(carry[5]),
        .s(s[6]),
        .co(carry[6])
    );
    Full_Adder FA8 (
        .a(a[7]),
        .b(b[7]),
        .ci(carry[6]),
        .s(s[7]),
        .co(co)
    );

endmodule