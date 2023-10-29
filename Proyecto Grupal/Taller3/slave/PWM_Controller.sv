module PWM_Controller (
  output logic [9:0] pwm_signal,  // Salida PWM de 10 bits
  input logic clock,              // Señal de reloj
  input logic reset              // Señal de reinicio opcional
);

  reg [9:0] counter;

  always_ff @(posedge clock or posedge reset) begin
    if (reset)
      counter <= 0;
    else if (counter < 10'b1010)
      counter <= counter + 1;
  end

  assign pwm_signal = counter;

endmodule

