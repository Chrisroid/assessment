# Live Tracking Assessment

A production-ready Flutter application demonstrating a high-fidelity, Uber-style live tracking screen. This project focuses on pixel-perfect UI execution, reactive state management, and advanced map animations.

## 🚀 Features & Bonus Objectives Completed

- **Smooth Marker Animation**: Built a custom interpolation engine inside the repository layer. It calculates microscopic sub-segments between real-world OSRM GPS coordinates and yields updates at ~30 FPS, resulting in buttery-smooth, realistic marker movement.
- **Stream-Based Reactive Architecture**: The entire tracking system is powered by a `Stream<LocationEntity>` managed by Riverpod. While currently simulating data over a route, the architecture is 100% plug-and-play ready for a real-time WebSocket connection without changing any UI code.
- **Custom Premium Map Styling**: Utilized `flutter_map` to strip away default Google Map constraints. Includes a **Dark/Light Mode Toggle** that seamlessly swaps out standard map tiles for premium **CartoDB Dark Matter** tiles, providing stunning contrast for the tracking UI.
- **Free-Floating Draggable UI**: The `BottomInfoSheet` is a custom-built, fully draggable floating widget. Users can grab the drag handle (or anywhere on the sheet) and dynamically move it around the screen to inspect the map underneath.
- **Pixel-Perfect UI & Typography**: Strict adherence to the provided Figma design specs, utilizing the Inter font family, customized timeline indicators, and dynamic state-driven styling.

## 🛠 Tech Stack & Architecture

- **Framework**: Flutter
- **Architecture**: Clean Architecture + MVVM
- **State Management**: Riverpod (`flutter_riverpod`)
- **Maps**: `flutter_map` with `latlong2`

## 📸 Demo & Downloads

> **Demo Video:** *[Insert Link to Video Here]*

> **Download APK:** *[Insert Link to APK Here]*

## 🧠 Architectural Decisions

1. **Clean Architecture**: Strict separation of concerns. The `TrackingRepositoryImpl` handles data generation and coordinate interpolation, the ViewModel (`TrackingViewModel`) processes state, and the UI reacts purely to changes.
2. **Widget Granularity**: Complex UI components (like the dynamic Timeline) are broken down into isolated builder methods and custom widgets (like the `DraggableFloatingSheet`) to ensure the tree remains highly readable and performant.
3. **Proprietary Protection**: This repository is provided without an open-source license (All Rights Reserved) to protect the proprietary nature of this assessment.

## 🏃‍♂️ Getting Started

To run this project locally:

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Connect an Android/iOS device or emulator
4. Run `flutter run`

To generate a production APK:
```bash
flutter build apk --debug
```

---
*Developed by Christian Shipa*
