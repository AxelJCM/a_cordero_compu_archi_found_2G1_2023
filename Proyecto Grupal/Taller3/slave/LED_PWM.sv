module LED_PWM(
  input logic clk,
  input logic [2:0] PWM_input,  // 4 bits para representar 10 intensidades (0 a 9)
  output logic LED,
  input logic input2,
  output logic a
);

  logic [3:0] PWM;  // Contador de 4 bits.

  always_ff @(posedge clk) begin
    if (PWM == 4'b1001) // Cuando llega a 9, reinicia a 0
      PWM <= 4'b0000;
    else
      PWM <= PWM + 1;
  end

  always_comb begin
    LED = (PWM < PWM_input) ? PWM : 4'b0000;
    a = input2;
  end

endmodule