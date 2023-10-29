module slave_tb;
    reg clk;
    reg rst_n;
    reg ss;
    reg mosi;
    wire miso;
    wire [3:0] led;

    // Instantiate the SPI_Slave module
    slave uut (
        .clk(clk),
        .rst_n(rst_n),
        .ss(ss),
        .mosi(mosi),
        .miso(miso),
        .led(led)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        rst_n = 1;
		  #5;
		  
        rst_n = 0;
		  #5;
		  
        rst_n = 1;
		  #5;
		  
        ss = 1;
        mosi = 0;
		  #5

        // Test 1: Send data
		  
		  //select
        ss = 0;
        mosi = 1;
        #5;
		  
		  //num 1010
		  mosi = 1;
        #5;
		  mosi = 0;
        #5;
		  mosi = 1;
        #5;
		  mosi = 0;
        #5;
		  
		  mosi = 0;
		  #5;
        
    end

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

endmodule
