import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/core/services/fitness_summary_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBmiCard extends StatelessWidget {
  const ProfileBmiCard({
    super.key,
    required this.height,
    required this.weight,
    required this.isDarkMode,
  });

  final String? height;
  final String? weight;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final bmi = FitnessSummaryService.calculateBmi(height, weight);
    final bmiCategory = FitnessSummaryService.getBmiCategory(bmi);
    final bmiColor = FitnessSummaryService.getBmiColor(bmi);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color.fromARGB(255, 34, 34, 34)
            : const Color.fromARGB(255, 245, 245, 247),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: bmiColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current BMI',
                  style: GoogleFonts.jost(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  bmi != null
                      ? bmi.toStringAsFixed(1)
                      : 'Enter Height & Weight',
                  style: GoogleFonts.fredoka(
                    fontSize: bmi != null ? 22 : 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? appcolorwhite : appcolorblack,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: bmiColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              bmiCategory,
              style: GoogleFonts.jost(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: bmiColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
