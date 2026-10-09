import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_form/core/theme/app_colors.dart';

/// Gradient text widget used throughout the application.
/// Replaces the global [LinearColors] function in app_colors.dart.
class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.gradientStart,
    required this.gradientEnd,
  });

  final String text;
  final double fontSize;
  final Color gradientStart;
  final Color gradientEnd;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [gradientStart, gradientEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: GoogleFonts.jost(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }
}
