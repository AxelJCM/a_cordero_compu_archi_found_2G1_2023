module Decodificador(
    input wire A, B, C, D,
    output wire a, b, c, d, e, f, g);
	 

    assign a = ((!A && !B && !C && D) || (!A && B && !C && !D)|| (A && !B && C && D)|| (A && B && !C && D));
    assign b = ((!A && B && !C && D) || (!A && B && C && !D)|| (A && !B && C && D)|| (A && B && !C && !D)|| (A && B && C && !D)|| (A && B && C && D));
    assign c = ((!A && !B && C && !D) || (A && B && !C && !D)|| (A && B && C && !D)|| (A && B && C && D));
    assign d = ((!A && !B && !C && D) || (!A && B && !C && !D)|| (!A && B && C && D)|| (A && !B && !C && D)|| (A && !B && C && !D)|| (A && B && C && D));
    assign e = ((!A && !B && !C && D) ||(!A && !B && C && D) || (!A && B && !C && !D)|| (!A && B && !C && D)|| (!A && B && C && D)|| (A && !B && !C && D));
    assign f = ((!A && !B && !C && D) || (!A && !B && C && !D)|| (!A && !B && C && D)|| (!A && B && C && D)|| (A && B && !C && D));
    assign g = ((!A && !B && !C && !D) || (!A && !B && !C && D)|| (!A && B && C && D)|| (A && B && !C && !D));
	 
endmodule