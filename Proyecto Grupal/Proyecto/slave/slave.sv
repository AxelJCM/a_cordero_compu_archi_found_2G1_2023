module slave(
    input wire clk,            // Señal de reloj
    input wire rst_n,          // Señal de reinicio asincrónico activa baja
    input wire ss,             // Señal de selección de esclavo
    input wire mosi,           // Señal MOSI (Master Out Slave In)
    output wire miso,          // Señal MISO (Master In Slave Out)
    output wire [0:3] led      // LEDs de salida
);

    reg [3:0] data_in;          // Registro para almacenar datos recibidos
    reg [0:3] shift_reg;              // Registro de desplazamiento para la comunicación SPI
    reg [2:0] bit_count;        // Contador de bits
    reg shift_done;             // Indicador de transferencia completa
	 reg respuesta; 
	 
    reg [1:0] communication_state;  // Estado de comunicación
    localparam IDLE = 2'b00;
	 localparam SEND = 2'b01;
    localparam RECEIVE = 2'b10;
    localparam END = 2'b11;

    // Lógica de la comunicación SPI
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg = 4'b0000;
            bit_count = 3'b000;
            shift_done = 1'b1;
            communication_state = IDLE;
        end else begin
            if (ss == 1'b0) begin
                case (communication_state)
                    IDLE: begin
                        if (mosi == 0) communication_state = END;
								if (mosi == 1 && shift_done == 1) communication_state = RECEIVE;								
						  end
						  
						  RECEIVE: begin
						  
								$display("en recieve %d", mosi);
                        shift_reg[bit_count] = mosi;
								respuesta= mosi;
                        bit_count = bit_count + 1'b1;
                        if (bit_count == 3'b100) begin
									$display("%b : %b", data_in, shift_reg);
									 data_in = shift_reg;
									 bit_count = 3'b000;
                            communication_state = IDLE;
                        end
							end
							
							END: begin
                        // Restablece el estado y espera la próxima comunicación
                        shift_done = 1'b1;
								shift_reg = 4'b0000;
                        communication_state = IDLE;
							end
                
					 endcase
            end else begin
					shift_reg = 4'b0000;
					bit_count = 3'b000;
					shift_done = 1'b1;
					communication_state = IDLE;
				end
        end
    end
    // Asignación de LEDs
    assign led = data_in;
	 assign miso = respuesta;

endmodule
