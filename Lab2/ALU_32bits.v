//---------------SPEC---------------
//  INPUT:  2 input a, b - 32 bits
//          1 opcode - 3 bit encode for 8 supported operators
//  OUTPUT: c - 32 bits
//  RELATION BETWEEN INPUT AND OUTPUT:
//      Opcode:
//         000 - Add: c = a + b
//         001 - Sub: c = a - b
//         010 - NOT: c = ~a
//         011 - AND: c = a & b
//         100 - OR: c = a | b
//         101 - XOR: c = a ^ b
//         110 - Arithmetic shift left: c = a <<< 1
//         111 - Arithmetic shift right: c = a >>> 1
//----------------------------------

module ALU_32bits (
    input [31:0] a, b,
    output reg [31:0] c,
    input [2:0] opcode
);
    
    always @(a or b or opcode) begin
        case (opcode)
            0: c = a + b;
            1: c = a - b;
            2: c = ~a;
            3: c = a & b;
            4: c = a | b;
            5: c = a ^ b;
            6: c = a <<< 1;
            7: c = a >>> 1;
            default: c = 32'b0;
        endcase
    end

endmodule