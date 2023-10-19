const int trigPin = 4;
const int echoPin = 6;
const int A = 12;  // Pin digital para el bit 0 de la salida Gray
const int B = 11;  // Pin digital para el bit 1 de la salida Gray
const int C = 10;  // Pin digital para el bit 2 de la salida Gray

int prevBinario = 0;

void setup() {
  Serial.begin(9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

int decimalToGray(int decimal) {
  return (decimal >> 1) ^ decimal;
}

void loop() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long duration = pulseIn(echoPin, HIGH);
  long distancia = (duration/2)/29;

  
  int binaryValue = map(distancia, 0, 30, 0, 7); // Mapear la duración a un valor binario de 3 bits
  if (distancia >30){
    binaryValue = 7;
  } 

  int grayValue = decimalToGray(binaryValue);

  if (prevBinario != binaryValue){
    digitalWrite(A,(grayValue & 0b100) ? LOW : HIGH);
    digitalWrite(B,(grayValue & 0b010) ? LOW : HIGH);
    digitalWrite(C,(grayValue & 0b001) ? LOW : HIGH);

  
    Serial.print("Duración: ");
    Serial.print(duration);
    Serial.print("µs, Distancia: ");
    Serial.print(distancia);
    Serial.print("cm, Gray Value: ");
    Serial.print(binaryValue);
    Serial.print("|");
    
    Serial.print((grayValue & 0b100) >> 2);
    Serial.print((grayValue & 0b010) >> 1);
    Serial.println((grayValue & 0b001) >> 0);
    prevBinario = binaryValue;
  }
  delay(1500); // Esperar un segundo antes de realizar la próxima medición
}

