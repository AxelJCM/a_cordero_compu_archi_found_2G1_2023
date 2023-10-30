module PWM (
    input clk,       // Entrada de reloj (50 MHz para DE0 Nano)
    output PWM_OUT   // Salida PWM
);

    reg [19:0] counter_PWM = 0;              // Contador para la frecuencia de PWM
    reg [3:0] pwm_range = 4'b1010;           // Rango del PWM (0-10)

    // PWM de 50 Hz y rango de 0-10
    always @(posedge clk) begin
        counter_PWM <= counter_PWM + 1;  // Incrementar el contador en cada ciclo de reloj
        if (counter_PWM >= 20'hF4240)    // Comparar el contador con la frecuencia requerida (50 Hz)
            counter_PWM <= 0;           // Reiniciar si es mayor
    end

    assign PWM_OUT = (counter_PWM < (pwm_range << 18)) ? 1'b1 : 1'b0; // Generar PWM en el rango de 0-10

endmodule