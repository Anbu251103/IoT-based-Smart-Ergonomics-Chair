# IoT-based-Smart-Ergonomics-Chair
This Smart Ergonomics Chair is designed for workplaces and home offices to encourage better sitting habits and improve ergonomic health.
📌 Project Overview
The Smart Ergonomics Chair is an IoT-based posture monitoring system designed to improve seating habits and prevent posture-related health issues. It utilizes sensors to detect incorrect sitting posture, prolonged sitting, and weight distribution, providing real-time feedback through LED and buzzer alerts.

🔧 Features
✅ Posture Monitoring: Detects improper back posture using an ultrasonic sensor.
✅ Seat Occupancy & Pressure Monitoring: Uses force sensors (FSR) to analyze weight distribution.
✅ Real-Time Alerts: Buzzer & LED notifications remind users to adjust posture.
✅ Break Reminder System: Notifies users after prolonged sitting periods.
✅ User Presence Detection: PIR sensor detects whether the user is seated.

🛠️ Components & Tools
Hardware
Arduino Nano – Microcontroller for sensor integration.
Ultrasonic Sensor (HC-SR04) – Measures distance to detect slouching.
PIR Sensor – Detects user presence.
Force Sensors (FSR) – Monitors weight distribution on the seat.
Buzzer & LED – Provides feedback for incorrect posture or inactivity.
Jumper Wires & Breadboard – For circuit connections.
Software
Arduino IDE – For coding and testing.
Tinkercad – For circuit simulation and validation.
📌 How It Works
User sits on the chair → The PIR sensor detects presence.
Posture monitoring begins → The ultrasonic sensor checks back position, and FSR sensors measure weight distribution.
If poor posture is detected:
Buzzer & LED alert the user to correct posture.
If sitting too long:
A break reminder is triggered using buzzer alerts.
System resets when the user leaves the chair.

📥 Installation & Setup
Download & Install Arduino IDE.
Connect sensors to Arduino as per the circuit diagram.
Upload the provided Arduino code to the microcontroller.
Monitor sensor readings via the Serial Monitor.
🚀 Future Enhancements
Bluetooth/WiFi Integration for remote data monitoring.
Mobile App for tracking sitting habits and analytics.
AI-based Posture Correction System using machine learning.
