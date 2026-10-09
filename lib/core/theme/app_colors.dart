import 'package:flutter/material.dart';

/// Type-safe, compile-time constant colours used across the entire app.
/// Usage:  color: AppColors.red
/// No more `dynamic` or raw `Colors.xxx` scattered across widgets.
class AppColors {
  AppColors._();

  static const Color red = Colors.red;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color blue = Colors.blue;
  static const Color green = Colors.green;
  static const Color orange = Colors.orange;
  static const Color yellow = Colors.yellow;
  static const Color grey = Colors.grey;
  static const Color pink = Colors.pink;

  // ── Semantic aliases ──────────────────────────────────────────────────
  static const Color primary = red;
  static const Color success = green;
  static const Color info = blue;
}
