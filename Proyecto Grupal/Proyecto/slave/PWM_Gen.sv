module PWM_Gen (
    input logic clock,
    input logic reset,
    input logic [3:0] switches,  // 4 interruptores para controlar los 10 niveles
    output logic pwm_out
);
    logic [7:0] counter;
    parameter [7:0] pwm_period = 8'h63; // Período ajustado para 10 niveles de potencia
    logic [3:0] pwm_level = 4'b0000;

    always_ff @(posedge clock or posedge reset) begin
        if (reset)
            counter <= 8'h00;
        else begin
            counter <= counter + 1;
            if (counter == pwm_period) begin
                counter <= 8'h00;
                pwm_level <= switches;
                pwm_out = (counter < (pwm_level << 1)) ? 1'b1 : 1'b0;
            end
        end
    end
endmodule
