module MotorControl (
  output [9:0] pwm_signal,     // Señal PWM de 10 bits
  output [6:0] seven_segment,  // Display de siete segmentos
  input logic clock,            // Señal de reloj
  input logic reset,            // Señal de reinicio opcional
  input logic [3:0] speed       // Valor normalizado de velocidad (0-10)
);

  reg [9:0] counter;

  always_ff @(posedge clock or posedge reset) begin
    if (reset)
      counter <= 10'b0;
    else if (counter < 10'b1010)
      counter <= counter + 1;
  end

  assign pwm_signal = (counter < speed) ? 10'b1010 : 10'b0;

  always_ff @(posedge clock) begin
    case(counter)
      10'b0000: seven_segment = 7'b1000000;  // 0 en display de siete segmentos
      10'b0001: seven_segment = 7'b1111001;  // 1 en display de siete segmentos
      10'b0010: seven_segment = 7'b0100100;  // 2 en display de siete segmentos
      10'b0011: seven_segment = 7'b0110000;  // 3 en display de siete segmentos
      10'b0100: seven_segment = 7'b0011001;  // 4 en display de siete segmentos
      10'b0101: seven_segment = 7'b0010010;  // 5 en display de siete segmentos
      10'b0110: seven_segment = 7'b0000010;  // 6 en display de siete segmentos
      10'b0111: seven_segment = 7'b1111000;  // 7 en display de siete segmentos
      10'b1000: seven_segment = 7'b0000000;  // 8 en display de siete segmentos
      10'b1001: seven_segment = 7'b0010000;  // 9 en display de siete segmentos
      default: seven_segment = 7'b0000000;   // Valor por defecto
    endcase
  end

endmodule
