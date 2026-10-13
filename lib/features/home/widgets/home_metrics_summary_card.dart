import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/core/services/fitness_summary_service.dart';
import 'package:fit_form/features/diet_planner/data/healthy_diet_data_source.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMetricsSummaryCard extends StatelessWidget {
  const HomeMetricsSummaryCard({
    super.key,
    required this.bmi,
    required this.bmiCategory,
    required this.bmiColor,
    required this.isDarkMode,
  });

  final double? bmi;
  final String bmiCategory;
  final Color bmiColor;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // BMI Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color.fromARGB(255, 34, 34, 34)
                    : const Color.fromARGB(255, 246, 246, 248),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: bmiColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.monitor_weight_outlined,
                          size: 18, color: bmiColor),
                      const SizedBox(width: 6),
                      Text(
                        'Current BMI',
                        style: GoogleFonts.jost(
                          fontSize: 13,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bmi != null ? bmi!.toStringAsFixed(1) : 'Not Set',
                    style: GoogleFonts.fredoka(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? appcolorwhite : appcolorblack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bmiCategory,
                    style: GoogleFonts.jost(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: bmiColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Diet Calories Card
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: healthyDietNotifier,
              builder: (context, _, __) {
                final todayCalories =
                    FitnessSummaryService.getTodayDietCalories();
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromARGB(255, 34, 34, 34)
                        : const Color.fromARGB(255, 246, 246, 248),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: appcolorRed.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_fire_department,
                              size: 18, color: appcolorRed),
                          const SizedBox(width: 6),
                          Text(
                            "Today's Diet",
                            style: GoogleFonts.jost(
                              fontSize: 13,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${todayCalories.toStringAsFixed(0)} kcal',
                        style: GoogleFonts.fredoka(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? appcolorwhite : appcolorblack,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Calories Consumed',
                        style: GoogleFonts.jost(
                          fontSize: 11,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
