#include <SPI.h>

const int CHIP = 10; // Pin de selección del esclavo en la FPGA


#define START_COMMUNICATION 0x01
#define END_COMMUNICATION   0x00

int currentValue = 0;

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
  
  byte dataToSend = 0b0000;
  currentValue++;
  if (currentValue > 10) {
    currentValue = 0; // Reinicia el valor si llega a 10
  }
  dataToSend |= (currentValue & 0x0F);


  byte dataReceived;
  byte ultimos4Bits;
  bool igual = false;
  
  startTime = millis(); // Registra el tiempo de inicio
  
  while (!igual && (millis() - startTime < 3000)) { // Continuar mientras no se alcance el tiempo límite
    dataReceived = SPI.transfer(currentValue);  // Envía los datos y recibe la respuesta
    ultimos4Bits = dataReceived;

  
    if ((dataToSend >> 1) == (ultimos4Bits % 8)) {
      igual = true;
      Serial.print("El número enviado por el arduino y regresado por la FPGA es: ");
      Serial.println(dataToSend);
    } else {
      Serial.print("Enviado: ");
      Serial.print(dataToSend, BIN);
      Serial.print(" Recibido: ");
      Serial.println(ultimos4Bits, BIN);
    }
  }
  
  digitalWrite(CHIP, HIGH);  // Desactiva la señal CHIP para finalizar la comunicación

  delay(5000);
}