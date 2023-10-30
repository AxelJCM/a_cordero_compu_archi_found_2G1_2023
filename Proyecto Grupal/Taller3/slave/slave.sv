module slave (
    input wire clk, mosi, ss, clock, // nombres de señales de entrada
    output wire miso, // nombre de salida de datos
    output reg led_select, // nombre de salida para seleccionar LEDs
	 output logic [6:0] display1, 
	 output logic out
);

    reg [0:3] shift_register= 4'b0000;
	 reg respuesta=1'b0;

    always @(posedge clk) begin
		shift_register = {shift_register[0:3],mosi}; // Actualización del registro de desplazamiento en el flanco de subida de clk
		miso = mosi;
    end
	 
    assign led_select = ss; // Asignación directa de la salida led_select al valor de select
	 
	 Decodificador dec(
			.A(shift_register[0]), 
			.B(shift_register[1]), 
			.C(shift_register[2]), 
			.D(shift_register[3]), 
			.a(display1[6]), 
			.b(display1[5]), 
			.c(display1[4]), 
			.d(display1[3]), 
			.e(display1[2]), 
			.f(display1[1]), 
			.g(display1[0])
			);
	 PWM_Controller pmw (
			.out(out), 
			.clock(clock), 
			.data(shift_register)
	 );
	 
endmodule
