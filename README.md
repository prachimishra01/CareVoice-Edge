# 🩺 CareVoice-Edge

## Privacy-Preserving Multimodal Patient Monitoring with Edge AI–Driven Behavioral Anomaly Detection and Voice-Assisted Healthcare Intervention

CareVoice-Edge is a Flutter-based healthcare monitoring application designed to support caregivers in monitoring patient activity, reminders, alerts, and safety-related events.

The project focuses on privacy-conscious patient monitoring and provides a caregiver-oriented mobile interface for patient activity, reminders, and safety-related information.



## ✨ Key Features

- 👩‍⚕️ Caregiver dashboard
- 📊 Patient activity monitoring
- 🚶 Activity and posture status
- 🚨 Fall detection interface
- 🔔 Caregiver alerts
- 🎙️ Voice-assisted reminders
- 💊 Reminder management
- 🛏️ Patient monitoring interface
- ⚠️ Emergency and alert interface
- 📱 Flutter-based Android application
- 🔒 Privacy-oriented monitoring approach

---
## Application Flow

The general application flow is:

Patient
↓
Camera / Sensors
↓
Edge Device
↓
Edge AI Processing
↓
Activity & Posture Analysis
↓
Anomaly Detection
↓
Alert Generation
↓
CareVoice-Edge Flutter App
↓
Caregiver Dashboard
↓
Caregiver

🛠️ Technology Stack
Technology :	Purpose
Flutter : Mobile application development
Dart : Application programming language
Android :	Mobile platform
OpenCV :	Computer vision
MediaPipe: Pose and activity analysis
Git :	Version control
GitHub :	Source code management

📂 Project Structure
CareVoice-Edge/
│
├── android/                 # Android application configuration
├── ios/                     # iOS configuration
├── lib/                     # Flutter application source code
│   ├── main.dart
│   ├── screens/
│   ├── widgets/
│   └── services/
│
├── test/                    # Flutter tests
├── web/                     # Flutter web configuration
├── windows/                 # Windows configuration
│
├── docs/                    # Project documentation
│   └── screenshots/         # Application screenshots
│
├── pubspec.yaml             # Flutter dependencies
├── pubspec.lock             # Dependency lock file
├── analysis_options.yaml    # Dart analysis configuration
├── .gitignore
└── README.md

🚀 Setup Guide
Prerequisites

Before running CareVoice-Edge, install the following:

Flutter SDK
Android Studio
Android SDK
Git
Android Emulator or physical Android device

Verify the Flutter installation:

flutter doctor

📥 Clone the Repository

Clone the repository using:

git clone https://github.com/YOUR_USERNAME/CareVoice-Edge.git

Navigate to the project directory:

cd CareVoice-Edge
📦 Install Dependencies

Install the Flutter project dependencies:

flutter pub get
📱 Connect an Android Device

You can run the application using either:

A physical Android device with USB debugging enabled
An Android Emulator configured through Android Studio

Check the available devices:

flutter devices
▶️ Run the Application

Run the application using:

flutter run

To run the application on a specific device:

flutter run -d DEVICE_ID

Example:

flutter run -d ZA2239TVTC