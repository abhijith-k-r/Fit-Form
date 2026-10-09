import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/core/services/fitness_summary_service.dart';
import 'package:fit_form/features/workouts/data/completed_workout_data_source.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTodayWorkoutsCard extends StatelessWidget {
  const HomeTodayWorkoutsCard({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ValueListenableBuilder(
        valueListenable: completedWorkoutNotifier,
        builder: (context, _, __) {
          final stats = FitnessSummaryService.getTodayWorkoutStats();
          final totalDone = stats['Total'] ?? 0;
          final beginnerDone = stats['Beginner'] ?? 0;
          final intermediateDone = stats['Intermediate'] ?? 0;
          final advancedDone = stats['Advanced'] ?? 0;

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [const Color(0xFF2C1810), const Color(0xFF1E1E1E)]
                    : [const Color(0xFFFFECEB), const Color(0xFFFFF7F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: appcolorRed.withValues(alpha: 0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: appcolorRed.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: appcolorRed,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.fitness_center,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Today's Workouts",
                          style: GoogleFonts.fredoka(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? appcolorwhite : appcolorblack,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: appcolorRed.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$totalDone Done',
                        style: GoogleFonts.jost(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: appcolorRed,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildChip('Beginner', beginnerDone, const Color(0xFF10B981)),
                    _buildChip('Intermediate', intermediateDone, const Color(0xFFF59E0B)),
                    _buildChip('Advanced', advancedDone, const Color(0xFFEF4444)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChip(String level, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color.fromARGB(255, 36, 36, 36) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                level,
                style: GoogleFonts.jost(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$count done',
            style: GoogleFonts.fredoka(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
