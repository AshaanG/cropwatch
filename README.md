# 🌱 Cropwatch

*A smart greenhouse system using ESP32, Firebase, Flutter, and JavaScript.*

---

## 📖 Overview
Cropwatch is a smart greenhouse monitoring and automation system.  
This repository contains the **mobile application** built with Flutter.  

> 🔗 Other components (web app, Arduino/ESP32 code) are maintained in separate repositories.

---

## 🚜 Problem Statement
Greenhouse conditions must be constantly monitored and adjusted.  
- Too hot → plants dry out and die.  
- Too cold → plants fail to grow.  
- Wrong humidity or soil moisture → increased plant diseases and crop death.  

**Cropwatch** solves this by automatically monitoring and regulating greenhouse conditions, while also giving farmers full control through mobile and web apps.  

---

## 🎯 Goals
- Automate greenhouse climate control to reduce crop loss.  
- Minimize plant diseases caused by poor conditions.  
- Provide farmers with real-time monitoring and remote manual control.  
- Make greenhouse farming more efficient and less labor-intensive.  

---

## ✨ Features
- 📊 Monitor **temperature, humidity, and soil moisture** in real time.  
- 📈 Visualize historical sensor data with charts.  
- ⚙️ Automatic control of:
  - Fan (cooling)  
  - Heater  
  - Water pump  
  - Lighting  
- 🎛️ Manual override controls from both **mobile app** and **web app**.  
- 🔄 Seamless data flow via Firebase.  

---

## 🔧 Hardware Components
- **ESP32** microcontroller  
- **DHT11** temperature & humidity sensor  
- **Soil moisture sensor**  
- Relays & level shifters  
- LCD display  
- Water pump  
- Heater  
- Cooling fan  

---

## 🖥️ Software Stack
- **Mobile App:** Flutter  
- **Web App:** JavaScript  
- **Cloud Backend:** Firebase Realtime Database  
- **Firmware:** Arduino / C for ESP32  

**Key Flutter Packages:**
- [`syncfusion_flutter_charts`](https://pub.dev/packages/syncfusion_flutter_charts)  

---

## 🔄 Data Flow
- **Sensors → ESP32 → Firebase → Mobile App / Web App**  
- **Manual Control → App/Web → Firebase → ESP32 → Devices**  

---

## ⚙️ Setup & Installation

### 1. Prerequisites
- Install [Flutter](https://docs.flutter.dev/get-started/install).  
- Setup an ESP32 with the Arduino sketch (🔗 link coming soon).  
- Setup a [Firebase Realtime Database](https://firebase.google.com/docs/database).  

### 2. Clone the Repo
```bash
git clone https://github.com/<your-username>/cropwatch-mobile.git
cd cropwatch-mobile.
```

---

# 📱 Usage

## Home Page
- View humidity, temperature, and soil moisture.  
- Switch between automatic and manual modes.  
- Manually control:  
  - Fan  
  - Heater  
  - Water pump  
  - Lighting  

## Charts Page
- View historic sensor readings (last 7 days).  

## Settings Menu
- Configure threshold values for automatic mode.  
  - e.g., Fan turns on at 25°C.  

---

# 🖼️ Screenshots



| Home Page | Charts Page |
|-----------|-------------|
| <img src="https://github.com/user-attachments/assets/ab0079c2-863e-41ef-927a-3458f8850550" width="300"> | <img src="https://github.com/user-attachments/assets/69fb2380-37ec-494f-833e-7f04c978b3cd" width="300"> |



---

# 👥 Contributors

- **Mobile App:** Ashaan Gunatilake 
- **Web App:** Aakil Ahmed  
- **Arduino/ESP32:** Ashaan Gunatilake, Aakil Ahmed, Senithu Liyanage  

---

# 🚀 Future Improvements

- Add support for more accurate sensors.  
- Improve data analytics for crop health predictions.  
- Enable multi-greenhouse scalability.  
- Add notifications (mobile alerts for threshold breaches).  
- Integrate with cloud dashboards for remote monitoring.  

---

# 📌 Note

This repository only contains the **mobile app codebase**.  

- [Web App Repo](#)  
- [Arduino/ESP32 Repo](#)

# 🔗 References

- [Firebase ESP Client (Arduino)](https://github.com/mobizt/FirebaseClient?tab=readme-ov-file)  
- [FlutterFire Documentation](https://firebase.flutter.dev/docs/)  
- [Arduino Firebase Library](https://docs.arduino.cc/libraries/firebase-esp32-client/)  
- [Syncfusion Flutter Charts](https://pub.dev/packages/syncfusion_flutter_charts)  


