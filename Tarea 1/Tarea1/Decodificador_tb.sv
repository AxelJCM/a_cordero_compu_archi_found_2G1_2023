module Decodificador_tb;
	logic A,B,C,a,b,c,d,e,f,g,m;
	
	Decodificador dut (A,B,C,a,b,c,d,e,f,g,m);
	
	initial begin 
		A=0;
		B=0;
		C=0;
		#10;
		$display("0 %b %b %b || %b %b %b %b %b %b %b || %b", A,B,C,a,b,c,d,e,f,g,m);
		
		
		A=0;
		B=0;
		C=1;
		#10;
		$display("1 %b %b %b || %b %b %b %b %b %b %b || %b", A,B,C,a,b,c,d,e,f,g,m);
		
		
		A=0;
		B=1;
		C=1;
		#10;
		$display("2 %b %b %b || %b %b %b %b %b %b %b || %b", A,B,C,a,b,c,d,e,f,g,m);
		
		
		A=0;
		B=1;
		C=0;
		#10;
		$display("3 %b %b %b || %b %b %b %b %b %b %b || %b", A,B,C,a,b,c,d,e,f,g,m);
		
		
		A=1;
		B=1;
		C=0;
		#10;
		$display("4 %b %b %b || %b %b %b %b %b %b %b || %b", A,B,C,a,b,c,d,e,f,g,m);
		
		
		A=1;
		B=1;
		C=1;
		#10;
		$display("5 %b %b %b || %b %b %b %b %b %b %b || %b", A,B,C,a,b,c,d,e,f,g,m);
		
		
		A=1;
		B=0;
		C=1;
		#10;
		$display("6 %b %b %b || %b %b %b %b %b %b %b || %b", A,B,C,a,b,c,d,e,f,g,m);
		
		
		A=1;
		B=0;
		C=0;
		#10;
		$display("7 %b %b %b || %b %b %b %b %b %b %b || %b", A,B,C,a,b,c,d,e,f,g,m);
		
		
		
	end
endmodule