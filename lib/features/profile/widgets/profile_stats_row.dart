import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/core/services/fitness_summary_service.dart';
import 'package:fit_form/features/diet_planner/data/healthy_diet_data_source.dart';
import 'package:fit_form/features/workouts/data/completed_workout_data_source.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDarkMode
        ? const Color.fromARGB(255, 34, 34, 34)
        : const Color.fromARGB(255, 245, 245, 247);

    return Row(
      children: [
        // Today's Calories
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: healthyDietNotifier,
            builder: (context, _, __) {
              final todayCals = FitnessSummaryService.getTodayDietCalories();
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
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
                          "Today's Calories",
                          style: GoogleFonts.jost(
                            fontSize: 12,
                            color:
                                isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$todayCals kcal',
                      style: GoogleFonts.fredoka(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? appcolorwhite : appcolorblack,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),

        // Today's Workouts Done
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: completedWorkoutNotifier,
            builder: (context, _, __) {
              final stats = FitnessSummaryService.getTodayWorkoutStats();
              final totalDone = stats['Total'] ?? 0;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.fitness_center,
                            size: 18, color: appcolorgreen),
                        const SizedBox(width: 6),
                        Text(
                          'Workouts Done',
                          style: GoogleFonts.jost(
                            fontSize: 12,
                            color:
                                isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$totalDone Completed',
                      style: GoogleFonts.fredoka(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? appcolorwhite : appcolorblack,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
