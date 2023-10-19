#include <SPI.h>

const int CS_PIN = 10;  // Pin de selección del esclavo en la FPGA

void setup() {
  Serial.begin(9600);
  SPI.begin();
  SPI.setDataMode(SPI_MODE0);  // Modo de comunicación SPI (ajusta según la FPGA)
  SPI.setClockDivider(SPI_CLOCK_DIV16);  // Divisor de frecuencia SPI
  pinMode(CS_PIN, OUTPUT);
  digitalWrite(CS_PIN, HIGH);  // Deseleccionar el esclavo al principio
}

void loop() {
  for (int velocidad = 0; velocidad <= 10; velocidad++) {
    enviarMensajeSPI(velocidad);
    delay(1000);  // Puedes ajustar el tiempo de espera entre velocidades
  }
}

void enviarMensajeSPI(int velocidad) {
  digitalWrite(CS_PIN, LOW);  // Seleccionar el esclavo
  byte mensaje = velocidad;  // El mensaje a enviar, puedes ajustarlo según tus necesidades
  
  // Enviar el mensaje a la FPGA a través de SPI
  byte ack = SPI.transfer(mensaje);
  
  digitalWrite(CS_PIN, HIGH);  // Deseleccionar el esclavo
  
  Serial.print("Mensaje enviado a FPGA: ");
  Serial.println(mensaje);
  
  Serial.print("Acknowledgement recibido desde FPGA: ");
  Serial.println(ack);
}

