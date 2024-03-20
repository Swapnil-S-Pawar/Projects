#define SENSOR_PIN_1 A0 // Pin for Sensor 1
#define SENSOR_PIN_2 A1 // Pin for Sensor 2

const int SAMPLE_INTERVAL = 1000 / 200; // Sampling interval in milliseconds (3.33 milliseconds per sample)

void setup() {
  Serial.begin(9600);
  pinMode(SENSOR_PIN_1, INPUT);
  pinMode(SENSOR_PIN_2, INPUT);
  Serial.println("Sensor 1, Sensor 2"); // Print the header row to the serial monitor
}

void loop() {
  static unsigned long previousMillis = millis();
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= SAMPLE_INTERVAL) {
    previousMillis = currentMillis;

    int sensorValue1 = analogRead(SENSOR_PIN_1);
    int sensorValue2 = analogRead(SENSOR_PIN_2);

    Serial.print(sensorValue1);
    Serial.print(", ");
    Serial.println(sensorValue2);
  }
}
