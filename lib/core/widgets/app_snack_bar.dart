import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_form/core/theme/app_colors.dart';

/// Reusable app-wide snack-bar helper.
/// Call via: AppSnackBar.show(context, 'Message', AppColors.green);
class AppSnackBar {
  AppSnackBar._();

  static void show(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: color,
        content: Text(
          message,
          style: GoogleFonts.jost(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static void success(BuildContext context, String message) =>
      show(context, message, AppColors.green);

  static void error(BuildContext context, String message) =>
      show(context, message, AppColors.red);
}
