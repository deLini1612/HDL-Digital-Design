//---------------SPEC---------------
//  INPUT:  - 2 operands a, b whose width is 1 bit
//          - carry in signal ci (1 bit)
//  OUTPUT: s - 1 bit output represent sum of a + b + ci
//          co - 1 bit represent carry out of operation
//----------------------------------

module Full_Adder (
    input a, b, ci,
    output s, co
);
    assign s = a ^ b ^ ci;
    assign co = ( a & b ) | ( a & ci ) | ( b & ci );
endmodule