# Fit-Form 🏋️‍♂️🥗

> **A comprehensive, offline-first personal fitness, workout tracking, and nutrition planning application built with Flutter & Hive.**

[![Flutter](https://img.shields.io/badge/Flutter-3.44+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Storage](https://img.shields.io/badge/Database-Hive%20NoSQL-orange?logo=hive&logoColor=white)](https://pub.dev/packages/hive)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green.svg)](#supported-platforms)
[![License](https://img.shields.io/badge/License-Private-red.svg)](#)

---

## 📌 Executive Summary

**Fit-Form** is an all-in-one mobile fitness companion designed to bridge the gap between workout routines and nutritional accountability. Engineered with an offline-first architecture powered by Hive NoSQL, the application delivers instant responsiveness, secure local data persistence, media playback for guided routines, and scheduled local notifications without requiring permanent cloud connectivity.

---

## 🚀 Key Features

### 🏋️ Workout Suite
* **Multi-Tier Routines:** Structured workouts divided into **Beginner**, **Intermediate**, and **Advanced** difficulty tiers.
* **Custom Workout Creation:** Build tailored exercise routines with custom sets, repetitions, target duration, and video demonstrations.
* **Integrated Video Player:** In-app playback (`video_player`) to preview form and exercise execution directly from local storage.
* **Workout Favorites:** Quick bookmarking system for high-frequency routines.

### ⏱️ Workout & Interval Timer
* **Dual Timer Modes:** Switch effortlessly between **Single Countdown** and **Interval Timer** for HIIT/Tabata workflows.
* **Interactive Audio/Visual Alerts:** Configurable interval sets and rest cycles to keep workout cadence on track.

### 🥗 Diet & Nutrition Planner
* **Calorie Calculator:** Select from curated food items or input custom gram metrics to compute caloric intake on the fly.
* **Healthy Diet Catalog:** Browse pre-configured dietary recommendations and customize personal nutritional guidelines.
* **Diet Bookmarks:** Save favorite meal and nutrition strategies for quick reference.

### 📊 Health Metrics & BMI Tracking
* **BMI Calculator:** Real-time Body Mass Index computation with categorized classifications (*Underweight, Normal, Overweight, Obese*).
* **Metric History:** Log historical BMI records with visual indicators to track physical transformation over time.

### 📅 Calendar & Event Scheduling
* **Interactive Activity Calendar:** Powered by `table_calendar` for organizing workout days and rest cycles.
* **Local Notifications:** Automated reminders via `flutter_local_notifications` for scheduled workouts and meal times.

### 🎨 Design & Experience
* **Dynamic Theme Engine:** Instant Light / Dark mode toggle powered by reactive `ValueNotifier`.
* **Modern Typography:** Styled with `GoogleFonts.jost`.
* **Smooth Micro-interactions:** Carousels (`carousel_slider`), smooth page indicators, and custom gradient accents.

---

## 🏛️ Architecture & Project Structure

The project follows a modular, feature-driven folder structure for maintainability and separation of concerns:

```
Fit-Form/
├── android/                             # Native Android configuration (AGP 8.6.1, Gradle 8.7)
├── ios/                                 # Native iOS workspace & Podfile configurations
├── asset/                               # Static media assets & images
│   ├── Diet_Plans_Images/
│   ├── Splashess_Images/
│   └── Work_Outs_Images/
├── lib/
│   ├── main.dart                        # Application entry point, Hive initialization, Theme provider
│   ├── App_Colors/                      # Application color palettes & design tokens
│   │   └── app_colors.dart
│   ├── Extracted_Functions/             # Reusable UI component builders & helper dialogs
│   │   ├── diet_tracker.dart
│   │   ├── extracted_functions.dart
│   │   └── form_fiels.dart
│   ├── functions/                       # Business logic & Hive CRUD repositories
│   │   ├── addworkouts.dart             # Workout state & Hive box operations
│   │   ├── auth.dart                    # User authentication & session handling
│   │   ├── bmi_functio.dart             # BMI calculations & persistent logs
│   │   ├── calendar_events.dart         # Calendar event management
│   │   ├── diet_funtions.dart           # Calorie calculations & food data
│   │   └── health_diet.dart             # Diet recommendations CRUD
│   ├── models/                          # Hive data schemas & code-generated TypeAdapters
│   │   ├── bmi_calculate.dart           # BMI record model
│   │   ├── bmi_calculator_model.dart    # BMI category model
│   │   ├── diet_plan_model.dart         # Diet meal schema
│   │   ├── events_modal.dart            # Scheduled calendar event schema
│   │   ├── healty_diet.dart             # Healthy diet entry schema
│   │   ├── usermodel.dart               # User authentication & profile schema
│   │   └── workouts_model.dart          # Workout entity schema
│   ├── Screens/                         # User Interface layers
│   │   ├── Authontications_Screens/     # Sign In, Sign Up & Onboarding gates
│   │   ├── Bottom_Nav_Screens.dart/     # Bottom navigation hub & main tabs
│   │   │   ├── home_screen.dart         # Dashboard with workout discovery
│   │   │   ├── calendar_events_scree.dart # Interactive calendar screen
│   │   │   ├── customize_screen.dart    # User custom workout hub
│   │   │   ├── profile.screen.dart      # User profile, statistics, dark mode toggle
│   │   │   └── DietPlanner/             # Calorie & BMI screens
│   │   ├── Inside_Screens/              # Drill-down detail, create & edit screens
│   │   ├── Extracted_Screens/           # Modals, confirmation dialogs
│   │   └── Splash_With_Get_Startss/     # Animated splash & get started flow
│   └── Timer/                           # Workout countdown & interval timer logic
│       └── workout_timer.dart
├── pubspec.yaml                         # Dependency definitions & asset declarations
└── README.md
```

---

## 🛠️ Technology Stack

| Layer | Technology | Details |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.44+ / Dart 3.12+ | Cross-platform mobile runtime |
| **Local Database** | Hive & Hive Flutter (`^1.1.0`) | Lightweight, fast key-value NoSQL storage |
| **Code Generation** | `build_runner` (`^2.4.13`) & `hive_generator` (`^2.0.1`) | Automated `TypeAdapter` binary serializers |
| **Notifications** | `flutter_local_notifications` (`^18.0.1`) | Android & iOS scheduled alerts (with Java desugaring) |
| **Media & Hardware** | `video_player` (`^2.9.2`), `image_picker` (`^1.1.2`) | Workout demonstration playback & gallery access |
| **UI Components** | `table_calendar`, `carousel_slider`, `smooth_page_indicator` | Modular UI widgets |
| **Typography** | `google_fonts` (`^6.3.3`) | Dynamic Google Fonts (Jost) |
| **Build Tools** | Android Gradle Plugin `8.6.1`, Gradle `8.7` | Modern Android compilation pipeline |

---

## ⚙️ Prerequisites & Environment Setup

Ensure the following SDKs are installed on your workstation:

* **Flutter SDK**: `>= 3.44.0` ([Installation Guide](https://docs.flutter.dev/get-started/install))
* **Dart SDK**: `>= 3.6.0`
* **JDK**: OpenJDK 17 or higher
* **Android Studio**: Android SDK Build-Tools 34+, Android SDK Command-line Tools
* **Physical Device or Android Emulator** with USB Debugging enabled

---

## 📦 Installation & Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/abhijith-k-r/Fit-Form.git
cd Fit-Form
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Hive Adapters
Whenever models inside `lib/models/` are modified, run `build_runner` to regenerate `*.g.dart` files:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Static Code Analysis
Ensure no linter warnings or syntax deprecations exist:
```bash
flutter analyze
```

---

## 📱 Running & Building

### Run in Debug Mode
Connect your device or start an emulator, then execute:
```bash
flutter run
```

### Build Android APK
Generate an optimized debug or release APK:

```bash
# Debug APK
flutter build apk --debug

# Production Release APK
flutter build apk --release
```
The output APK will be available under `build/app/outputs/flutter-apk/`.

### Build Android App Bundle (AAB)
For Google Play distribution:
```bash
flutter build appbundle --release
```

---

## 🛡️ Best Practices & Quality Standards

* **Clean Architecture:** Keep business logic and box manipulation separated inside `lib/functions/` rather than embedding directly in widget trees.
* **Hive Type IDs:** Ensure unique `@HiveType(typeId: X)` IDs when introducing new models to avoid serializer collisions.
* **Safe Form Fields:** Prefer `initialValue` over deprecated `value` attributes in `DropdownButtonFormField`.
* **Theme Reactivity:** Leverage `ValueListenableBuilder` connected to global `ValueNotifier<bool> isDark` to provide instant UI updates without complete app reinvocations.

---

## 📄 License
This project is private and proprietary. All rights reserved.
