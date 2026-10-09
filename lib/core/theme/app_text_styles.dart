import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralised text-style factory.
/// Usage: style: AppTextStyles.bodyMedium(context)
class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading(double fontSize) => GoogleFonts.jost(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle body(double fontSize) => GoogleFonts.jost(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      );

  static TextStyle semiBold(double fontSize) => GoogleFonts.jost(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      );

  static TextStyle label(double fontSize) => GoogleFonts.jost(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      );
}
