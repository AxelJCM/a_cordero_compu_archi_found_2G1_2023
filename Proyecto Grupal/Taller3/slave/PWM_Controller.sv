module PWM_Controller (
  output logic led, 
  input logic clock, 
  input wire switches [3:0]
);

reg[7:0] counter = 0;

always@(posedge clock) begin 
	if (counter < 10) counter <= counter +1;
	else counter <=0;
end

assign led = (counter< (switches[0] + switches[1] *2 + switches[2] * 4 + switches[3] * 8) ) ? 1:0;

endmodule

