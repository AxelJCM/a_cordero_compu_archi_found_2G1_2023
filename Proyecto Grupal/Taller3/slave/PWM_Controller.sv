module PWM_Controller (
  output logic led, 
  input logic clock, 
  input wire switches [3:0]
);

reg[7:0] counter = 0;
wire reset_counter;

assign reset_counter = (counter == 10'b1111) ? 1'b1 : 1'b0;

always @(posedge clock or posedge reset_counter) begin
    counter <= reset_counter ? 8'b0000_0000 : counter + 1;
end

assign led = (counter < (switches[0] + switches[1] * 2 + switches[2] * 4 + switches[3] * 8)+4) ? 1'b1 : 1'b0;

endmodule
