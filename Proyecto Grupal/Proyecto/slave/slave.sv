module slave (
    input wire clk, data_in, select, // nombres de señales de entrada
    output reg data_out, // nombre de salida de datos
    output reg led_select, // nombre de salida para seleccionar LEDs
    output reg [3:0] leds // nombre de salida para controlar los LEDs
);

    reg [0:3] shift_register;

    initial begin
        shift_register = 4'b0000; // Registro de desplazamiento de 4 bits inicializado en 0000
    end

    always @(posedge clk) begin
        shift_register <= {shift_register[0:3],data_in}; // Actualización del registro de desplazamiento en el flanco de subida de clk
        leds <= select ? leds : shift_register; // Actualización de la salida LEDs basada en la señal select
        data_out <= select ? data_out : shift_register[0:3]; // Actualización de la salida data_out basada en la señal select
    end

    assign led_select = select; // Asignación directa de la salida led_select al valor de select

endmodule
