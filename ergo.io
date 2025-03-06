// Sensor Pins
const int pirPin = 2;         // PIR sensor for user presence
const int trigPin = 3;        // Ultrasonic Trigger pin
const int echoPin = 4;        // Ultrasonic Echo pin
const int seatFSR = A0;       // Seat force sensor (FSR)
const int backFSR = A1;       // Backrest force sensor (FSR)

// Output Pins
const int ledPin = 7;         // LED indicator for posture feedback
const int buzzerPin = 8;      // Buzzer for alerts

// Thresholds
const int seatMinPressure = 100;  // Minimum pressure for detecting sitting
const int backMinPressure = 50;   // Minimum backrest pressure for good posture
const int optimalMin = 10;        // Min ultrasonic distance for good posture
const int optimalMax = 15;        // Max ultrasonic distance for good posture

// Timing Variables
unsigned long poorPostureStart = 0;
unsigned long sittingStart = 0;
bool isUserSitting = false;
bool postureAlertActive = false;
const unsigned long postureAlertDelay = 30000;  // 30 sec for posture correction
const unsigned long breakThreshold = 3600000;   // 1 hour for break reminder

void setup() {
  pinMode(pirPin, INPUT);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(buzzerPin, OUTPUT);
  
  Serial.begin(9600);
}

long readUltrasonicDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  long duration = pulseIn(echoPin, HIGH);
  return duration * 0.034 / 2;
}

void loop() {
  int pirState = digitalRead(pirPin);
  int seatPressure = analogRead(seatFSR);
  int backPressure = analogRead(backFSR);

  // Check if user is sitting based on PIR and seat FSR
  if (pirState == HIGH && seatPressure > seatMinPressure) {
    if (!isUserSitting) {
      isUserSitting = true;
      sittingStart = millis();
      Serial.println("User seated");
    }

    long distance = readUltrasonicDistance();
    Serial.print("Distance: "); Serial.println(distance);
    Serial.print("Seat Pressure: "); Serial.println(seatPressure);
    Serial.print("Back Pressure: "); Serial.println(backPressure);

    // Check if posture is good
    if (distance >= optimalMin && distance <= optimalMax && backPressure > backMinPressure) {
      digitalWrite(ledPin, HIGH);
      digitalWrite(buzzerPin, LOW);
      poorPostureStart = 0;
      postureAlertActive = false;
      Serial.println("Good posture");
    } else {
      digitalWrite(ledPin, LOW);

      if (poorPostureStart == 0) {
        poorPostureStart = millis();
      }

      if ((millis() - poorPostureStart >= postureAlertDelay) && !postureAlertActive) {
        digitalWrite(buzzerPin, HIGH);
        postureAlertActive = true;
        Serial.println("Poor posture alert! Please adjust your sitting position.");
      }
    }

    if (millis() - sittingStart >= breakThreshold) {
      digitalWrite(buzzerPin, HIGH);
      Serial.println("Time for a break!");
      sittingStart = millis();
    }
  } else {
    isUserSitting = false;
    poorPostureStart = 0;
    digitalWrite(ledPin, LOW);
    digitalWrite(buzzerPin, LOW);
  }

  delay(200);
}
