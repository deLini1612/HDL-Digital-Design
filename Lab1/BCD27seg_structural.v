// Implementation BCD to 7seg decoder using structural model
//In DE2-70 Board has 8 7-seg COMMON ANODE displays (logic 0 is light)
module BCD27seg_structural (
    input [3:0]in,
    output a, b, c, d, e, f, g
);

    wire n0, n1, n2, n3,
        in3Andin1, in3Andin2, in2Andn1Andin0, in2Andin1Andn0, n2Andin1Andn0,
        in2Andn1Andn0, in2Andin1Andin0, n3Andn2Andn1, n3Andn2Andn1Andin0, in2Andn1,
        in1Andin0, n3Andn2Andin0, n2Andin1;

    not N1(n0, in[0]);
    not N2(n1, in[1]);
    not N3(n2, in[2]);
    not N4(n3, in[3]);

    and A1(in3Andin1, in[3], in[1]);
    and A2(in3Andin2, in[3], in[2]);
    and A4(in2Andn1Andin0, in[2], n1, in[0]);
    and A5(in2Andin1Andn0, in[2], in[1], n0);
    and A6(n2Andin1Andn0, n2, in[1], n0);
    and A7(in2Andn1Andn0, in[2], n1, n0);
    and A8(in2Andin1Andin0, in[2], in[1], in[0]);
    and A14(n3Andn2Andn1, n3, n2, n1);
    and A9(n3Andn2Andn1Andin0, n3Andn2Andn1, in[0]);
    and A10(in2Andn1, in[2], n1);
    and A11(in1Andin0, in[1], in[0]);
    and A12(n3Andn2Andin0, n3, n2, in[0]);
    and A13(n2Andin1, n2, in[1]); 

    or O1(a, in3Andin1, in3Andin2, in2Andn1Andn0, n3Andn2Andn1Andin0);
    or O2(b, in3Andin1, in3Andin2, in2Andn1Andin0, in2Andin1Andn0);
    or O3(c, in3Andin1, in3Andin2, n2Andin1Andn0);
    or O4(d, in3Andin1, in3Andin2, in2Andn1Andn0, in2Andin1Andin0, n3Andn2Andn1Andin0);
    or O5(e, in[0], in2Andn1, in3Andin1);
    or O6(f, in3Andin2, in1Andin0, n3Andn2Andin0, n2Andin1);
    or O7(g, in3Andin1, in3Andin2, n3Andn2Andn1, in2Andin1Andin0);

endmodule