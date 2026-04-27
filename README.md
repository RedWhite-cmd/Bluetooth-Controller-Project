Bluetooth Controller Project
A robust iOS application developed with Swift and SwiftUI designed to interface with hardware via Bluetooth Low Energy (BLE). This project allows for real-time data transmission and control, specifically configured to work with ESP32 microcontrollers.

🚀 Features
BLE Connectivity: Seamless scanning and connection to nearby Bluetooth peripherals.

Real-time Interaction: Bi-directional communication between the iOS device and ESP32 hardware.

Dynamic UI: Responsive interface built with SwiftUI to monitor values and send control commands.

Hardware Integration: Includes dedicated C++ firmware (ESP32_Code) to get the hardware side running immediately.

🛠 Tech Stack
iOS: Swift, SwiftUI, CoreBluetooth

Hardware: C++, ESP32 Firmware

Tools: Xcode

📂 Repository Structure
ControllerApp: The main iOS source code.

ESP32_Code: Firmware for the microcontroller to handle Bluetooth characteristics.

ControllerApp.xcodeproj: Xcode project file for easy setup.

🏁 Getting Started
Prerequisites
A Mac running Xcode.

An iOS device (Physical device required for Bluetooth testing; Simulators do not support BLE).

An ESP32 or compatible Bluetooth-enabled microcontroller.

Installation
Clone the repository:

Bash
git clone https://github.com/RedWhite-cmd/Bluetooth-Controller-Project.git
Hardware Setup:

Navigate to the ESP32_Code folder.

Flash the code to your ESP32 using the Arduino IDE or PlatformIO.

iOS Setup:

Open ControllerApp.xcodeproj in Xcode.

Ensure your signing certificates are configured.

Build and Run on your physical iPhone/iPad.

🤝 Contributors
Sudeep Reddy Thatiparthi (RedWhite-cmd)

Paul O'Connell (Liveoaks27)

How to use this:
Go to your Bluetooth-Controller-Project on GitHub.

Click the pencil icon on the README.md file to edit.

Paste the content above and click Commit changes.

Does this cover everything you wanted to highlight, or should I add a specific "Usage" section for the app's controls?
