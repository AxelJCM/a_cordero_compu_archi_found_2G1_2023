module Decodificador(
    input logic A, B, C,
    output logic a, b, c, d, e, f, g, m);
	 
		 assign a = ~( (~A && B) || (~B && ~C) || (A && C) );
		 assign b = ~(~A || ~C);
		 assign c = ~(~B || ~C || A);
		 assign d = ~( (~A && ~C) || (B && C) || (A && C) );
		 assign e = ~( (~A && ~B && ~C) || (~A && B && C) || (A && ~B && C));
		 assign f = ~((A && B) || (A && C) || (~A && ~B && ~C));
		 assign g = ~(B || (A && C));
		 assign m = ~( (B && C) );
endmodule
