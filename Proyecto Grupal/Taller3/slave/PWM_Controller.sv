module PWM_Controller (
  output logic out, 
  input logic clock, 
  input reg [0:3] data 
);

	reg[7:0] counter = 0;
	wire reset_counter;

	assign reset_counter = (counter == 10'b1111) ? 1'b1 : 1'b0;

	always @(posedge clock or posedge reset_counter) begin
		 counter <= reset_counter ? 8'b0000_0000 : counter + 1;
	end

	assign out = (counter < (data[3] + data[2] * 2 + data[1] * 4 + data[0] * 8)+4) ? 1'b1 : 1'b0;

endmodule
