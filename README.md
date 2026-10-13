# Fit-Form 🏋️‍♂️🥗

> **A modern, offline-first personal fitness companion, workout tracker, and nutrition planner built with Flutter and Hive NoSQL.**

[![Flutter](https://img.shields.io/badge/Flutter-3.27+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Storage](https://img.shields.io/badge/Database-Hive%20NoSQL-orange?logo=hive&logoColor=white)](https://pub.dev/packages/hive)
[![Platform](https://img.shields.io/badge/Platform-Android%20(Release%20Ready)-green.svg)](https://developer.android.com)
[![Build](https://img.shields.io/badge/Build-Passing%20(0%20errors)-brightgreen.svg)](#verification--quality-checks)
[![License](https://img.shields.io/badge/License-Private-red.svg)](#license)

---

## 📌 Overview

**Fit-Form** is an all-in-one mobile fitness application engineered for speed, privacy, and reliability. It combines structured workout routines, custom interval training, dynamic nutrition logging, real-time BMI analytics, and calendar goal tracking into an intuitive, responsive mobile experience.

Built with a local-first architecture powered by **Hive NoSQL**, all personal biometric records, workouts, calendar goals, and meal entries persist securely on the user's device without requiring an external backend or constant network connectivity.

---

## ✨ Key Features

### 🏋️ Workouts & Exercise Discovery
* **Tiered Workout Levels:** Structured exercise programs categorized into **Beginner**, **Intermediate**, and **Advanced** difficulties.
* **Custom Workout Creation:** Build personal routines with custom names, sets, repetitions, target durations, benefit descriptions, and photo attachments.
* **Integrated Video Player:** Form and demonstration playback powered by [`video_player`](https://pub.dev/packages/video_player) directly within exercise detail views.
* **Favorites System:** One-tap bookmarking for quick access to go-to exercises.

### ⏱️ Workout & Interval Timer
* **Dual-Mode Training:** Seamlessly switch between standard session countdowns and structured interval routines (Work / Rest cadence).
* **Round & Cadence Tracking:** Visual circular progress indicators with automated round progression and interactive pause/resume/reset controls.

### 🥗 Nutrition & Diet Planning
* **Dynamic Calorie Calculator:** Track daily caloric intake by selecting cataloged foods or adding custom meal items with gram-accurate energy values.
* **Healthy Meal Catalog:** Curated nutritional strategies and meal suggestions.
* **Date-Filtered Meal History:** Filter meals and caloric totals by *Today*, *This Week*, *This Month*, *This Year*, or custom calendar dates.

### 📊 Health Analytics & BMI Tracking
* **Real-Time BMI Calculator:** Instant Body Mass Index computation with color-coded classifications (*Underweight, Normal, Overweight, Obese*).
* **Biometric Recommendations:** Context-aware exercise and nutrition advice tailored to the user's latest recorded BMI.
* **Historical Logs:** Persisted calculation history with easy clear and review functionality.

### 📅 Calendar & Goal Tracking
* **Interactive Activity Calendar:** Powered by [`table_calendar`](https://pub.dev/packages/table_calendar) to schedule goals and track consistency across months and weeks.
* **Goal Checklists:** Add, edit, check off, and delete daily milestones and fitness targets.

### 👤 Profile & Theme Customization
* **Personalized Biometrics:** Configure name, age, height, weight, and custom profile photo with quick on-device image selection ([`image_picker`](https://pub.dev/packages/image_picker)).
* **Reactive Dark Mode Engine:** Instant Light / Dark theme switching powered by [`ValueNotifier`](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) without reloading application state.
* **Streamlined Onboarding:** Smooth first-time walkthrough with one-tap skip straight into the application dashboard.

---

## 🏛️ Project Architecture & Clean Screen Design

The codebase adheres to a modular, feature-oriented structure with clear separation between state management, local persistence, and user interface components.

The five primary screens hosted by the bottom navigation bar follow a strict single-responsibility design, keeping each primary screen file concise and focused (under 100 lines of code) by extracting dedicated presentation widgets:

```
Fit-Form/
├── android/                             # Android native configuration (AGP 8.11.1, Kotlin 2.2.20)
│   ├── app/
│   │   ├── build.gradle                 # Release signing configs & desugaring setup
│   │   └── src/main/AndroidManifest.xml
│   └── build.gradle
├── asset/                               # Optimized static media assets
│   ├── Diet_Plans_Images/               # Food & meal catalog imagery
│   ├── Splashess_Images/                # Brand logos & onboarding splash art
│   └── Work_Outs_Images/                # Workout difficulty & exercise demonstrations
├── lib/
│   ├── main.dart                        # Application entry point & theme listener
│   ├── App_Colors/
│   │   └── app_colors.dart              # Global color palette & gradient shaders
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_keys.dart            # Centralized Hive box identifiers
│   │   └── services/
│   │       ├── app_initializer.dart     # Single-point Hive adapter registration
│   │       ├── fitness_summary_service.dart # BMI classification & color calculation logic
│   │       └── media_picker_service.dart # Image picking utilities
│   ├── features/
│   │   ├── calendar_events/             # Calendar, goal tracking & customize tab
│   │   │   ├── data/                    # Calendar Hive data sources
│   │   │   ├── screens/                 # Primary: calendar_events_scree.dart (86 lines)
│   │   │   │                            # Primary: customize_screen.dart (77 lines)
│   │   │   └── widgets/                 # Calendar tables & goal modal sheets
│   │   ├── diet_planner/                # Nutrition, food catalog & BMI services
│   │   │   ├── data/                    # Diet & healthy diet Hive data sources
│   │   │   ├── screens/                 # Primary: diet_track_menu_screen.dart (74 lines)
│   │   │   └── widgets/                 # Diet cards & food dialogs
│   │   ├── home/                        # Dashboard & Navigation Shell
│   │   │   ├── screens/                 # Primary: home_screen.dart (81 lines)
│   │   │   │                            # Shell: bottom_nave_screen.dart (88 lines)
│   │   │   └── widgets/                 # Carousels, metrics summary & level categories
│   │   ├── onboarding/                  # Welcome splash & initial profile setup
│   │   └── profile/                     # User biometric profile & preferences
│   │       ├── data/                    # UserDataSource (profile persistence)
│   │       ├── screens/                 # Primary: profile.screen.dart (77 lines)
│   │       │                            # Edit Profile: edit_profile.dart
│   │       └── widgets/                 # Profile header, stats row & preference card
│   ├── functions/                       # Compatibility shims & Hive CRUD helpers
│   ├── models/                          # Data models with code-generated Hive TypeAdapters
│   ├── Screens/                         # Drill-down workout details & category screens
│   └── Timer/                           # Workout countdown & interval timers
├── pubspec.yaml                         # Clean, minimal dependency manifest
└── README.md
```

### Primary Screen Maintainability Benchmark

| Screen | File Location | Line Count | Target (<100) |
|---|---|:---:|:---:|
| **Home Dashboard** | `lib/features/home/screens/home_screen.dart` | **81** | ✅ Passed |
| **Calendar & Goals** | `lib/features/calendar_events/screens/calendar_events_scree.dart` | **86** | ✅ Passed |
| **Diet Track Menu** | `lib/features/diet_planner/screens/diet_track_menu_screen.dart` | **74** | ✅ Passed |
| *(BMI Calculator)* | `lib/Screens/Bottom_Nav_Screens.dart/DietPlanner/bmi_calculator.dart` | **86** | ✅ Passed |
| **Customize Workouts** | `lib/features/calendar_events/screens/customize_screen.dart` | **77** | ✅ Passed |
| **Profile & Settings** | `lib/features/profile/screens/profile.screen.dart` | **77** | ✅ Passed |
| **Bottom Navigation Shell** | `lib/features/home/screens/bottom_nave_screen.dart` | **88** | ✅ Passed |

---

## 🛠️ Technology Stack & Dependencies

```yaml
dependencies:
  carousel_slider: ^5.0.0      # Interactive carousel displays
  flutter:
    sdk: flutter
  google_fonts: ^6.3.3         # Typography (Jost, Fredoka)
  hive_flutter: ^1.1.0         # Lightweight, reactive NoSQL database
  image_picker: ^1.1.2         # Profile picture & workout media upload
  intl: ^0.20.1                # Date formatting & internationalization
  path_provider: ^2.1.5        # Local file system storage paths
  table_calendar: ^3.1.3       # Dynamic calendar view
  video_player: ^2.9.2         # In-app exercise demonstration video playback

dev_dependencies:
  build_runner: ^2.4.13        # Code generation tool
  flutter_launcher_icons: ^0.14.2 # Multi-platform app icon generator
  flutter_lints: ^5.0.0        # Official Flutter lint rules
  flutter_test:
    sdk: flutter
  hive_generator: ^2.0.1       # Hive TypeAdapter generator
```

*Note: Unused dependencies (`flutter_local_notifications`, `flutter_switch`, `gradient_borders`, `smooth_page_indicator`, `cupertino_icons`) and obsolete authentication screens were removed during codebase cleanup to optimize build times and bundle sizes.*

---

## 🚀 Getting Started

### Prerequisites
* **Flutter SDK:** `>= 3.27.0` ([Flutter Installation Guide](https://docs.flutter.dev/get-started/install))
* **Dart SDK:** `>= 3.6.0`
* **Java Development Kit (JDK):** Version 17 or higher
* **Android SDK:** Platform SDK 34+, Android Build-Tools

### 1. Clone the Repository
```bash
git clone https://github.com/abhijith-k-r/Fit-Form.git
cd Fit-Form
```

### 2. Fetch Dependencies
```bash
flutter pub get
```

### 3. Generate Hive Adapters (If Models Are Updated)
Whenever models inside `lib/models/` are modified, run `build_runner` to regenerate `*.g.dart` files:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Verification & Quality Checks
Run static analysis to confirm zero errors or linter warnings:
```bash
flutter analyze
```

---

## 📦 Building Production Release APKs

### 1. Build Universal Release APK
To produce a single, universal APK that runs on all supported Android device architectures:
```bash
flutter build apk --release
```
* **Output Path:** `build/app/outputs/flutter-apk/app-release.apk` (~61.4 MB)

### 2. Build Architecture-Optimized APKs (Recommended for Testing)
To generate smaller, hardware-specific APKs tailored to specific processor architectures:
```bash
flutter build apk --split-per-abi
```
* **ARM64 (Modern 64-bit phones):** `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` (~26.7 MB)
* **ARMv7 (Legacy 32-bit phones):** `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk` (~24.4 MB)
* **x86_64 (Emulators & ChromeOS):** `build/app/outputs/flutter-apk/app-x86_64-release.apk` (~28.2 MB)

---

## 📱 Testing on a Physical Android Device

### Method 1: Direct Installation via ADB
Connect your Android device via USB with **USB Debugging** enabled, then run:
```bash
adb install -r build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

### Method 2: Manual Sideloading
1. Transfer `app-release.apk` (or `app-arm64-v8a-release.apk`) to your phone via USB, Google Drive, or messaging.
2. Open your device's File Manager, tap the `.apk` file, grant permission to *"Install from unknown sources"*, and complete the installation.

---

## 🌐 Google Play Store Release Preparation

The project currently uses a fallback debug signing configuration (`signingConfig = keystorePropertiesFile.exists() ? signingConfigs.release : signingConfigs.debug`) so release APKs can be tested immediately on physical devices without setup hurdles.

When ready to publish to Google Play:
1. **Generate a Production Keystore:**
   ```bash
   keytool -genkey -v -keystore android/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. **Configure `android/key.properties`:**
   ```properties
   storePassword=<your-store-password>
   keyPassword=<your-key-password>
   keyAlias=upload
   storeFile=../upload-keystore.jks
   ```
   *(Ensure `key.properties` and `.jks` are excluded in `.gitignore`)*.
3. **Build the Android App Bundle (AAB):**
   ```bash
   flutter build appbundle --release
   ```
   * **Output Path:** `build/app/outputs/bundle/release/app-release.aab`

---

## 📄 License
This project is private and proprietary. All rights reserved.
