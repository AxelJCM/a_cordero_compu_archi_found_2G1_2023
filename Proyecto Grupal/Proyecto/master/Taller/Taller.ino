#include <SPI.h>

const int CHIP = 10; // Pin de selección del esclavo en la FPGA


#define START_COMMUNICATION 0x01
#define END_COMMUNICATION   0x00


unsigned long startTime = 0;

void setup() {
  
  pinMode(CHIP, OUTPUT);
  SPI.setDataMode(SPI_MODE0);  // Modo de comunicación SPI (ajusta según la FPGA)
  SPI.setBitOrder(MSBFIRST);   // Orden de bits más significativos primero
  SPI.setClockDivider(SPI_CLOCK_DIV16);  // Divisor de frecuencia SPI
  digitalWrite(CHIP, HIGH);  // Deseleccionar el esclavo al principio
  Serial.begin(9600);
  SPI.begin();
}


void loop() {
  // Iniciar la comunicación
  digitalWrite(CHIP, LOW);  
  

  byte dataToSend = 0b10000; 
  byte randomBits = random(16);
  dataToSend |= (randomBits & 0x0F);
  dataToSend <<= 1;
  Serial.println(dataToSend, BIN);
  
  byte dataReceived;
  byte ultimos4Bits;
  bool igual = false;
  
  startTime = millis(); // Registra el tiempo de inicio
  
  while (!igual && (millis() - startTime < 3000)) { // Continuar mientras no se alcance el tiempo límite
    dataReceived = SPI.transfer(dataToSend);  // Envía los datos y recibe la respuesta
    ultimos4Bits = dataReceived & 0x0F;  // Aplica una máscara para obtener los últimos 4 bits
    Serial.println(ultimos4Bits, BIN);
  
    if (randomBits == ultimos4Bits) {
      igual = true;
      Serial.println("Los últimos 4 bits de dataToSend y ultimos4Bits son iguales.");
    } else {
      Serial.println("Los últimos 4 bits de dataToSend y ultimos4Bits son diferentes. Reenviando el mensaje.");
    }
  }
  
  digitalWrite(CHIP, HIGH);  // Desactiva la señal CHIP para finalizar la comunicación

  delay(5000);  
}

