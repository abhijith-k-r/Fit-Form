import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/Timer/workout_timer.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutDetailsSection extends StatelessWidget {
  const WorkoutDetailsSection({
    super.key,
    required this.work,
    required this.isDarkMode,
    required this.screenWidth,
  });

  final WorkoutsModel? work;
  final bool isDarkMode;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Difficulty Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                work?.workoutsName ?? 'Exercise',
                style: GoogleFonts.jost(
                  fontSize: screenWidth * 0.058,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? appcolorwhite : appcolorblack,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: appcolorRed.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                work?.difficulty ?? 'Beginner',
                style: GoogleFonts.jost(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: appcolorRed,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Sets, Reps, Duration row
        Row(
          children: [
            workoutInfo(context, Icons.fitness_center_outlined,
                work?.numberOfSets ?? '3 Sets'),
            const SizedBox(width: 8),
            workoutInfo(
                context, Icons.repeat_outlined, work?.reps ?? '12 Reps'),
            const SizedBox(width: 8),
            workoutInfo(context, Icons.timer, work?.duration ?? '45s'),
          ],
        ),
        const SizedBox(height: 20),

        // Benefits
        workoutsection(context, Icons.info_outline, 'Benefits'),
        const SizedBox(height: 8),
        Text(
          work?.benifits?.isNotEmpty == true
              ? work!.benifits!
              : 'Improves muscular strength, endurance, and overall physical posture.',
          style: GoogleFonts.jost(
            fontSize: screenWidth * 0.042,
            color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
          ),
        ),
        const SizedBox(height: 20),

        // How to Do
        workoutsection(context, Icons.menu_book, 'How to Do'),
        const SizedBox(height: 8),
        Text(
          work?.woroutSteps?.isNotEmpty == true
              ? work!.woroutSteps!
              : '1. Maintain a strong core.\n2. Keep your back straight.\n3. Breathe steadily throughout the exercise.',
          style: GoogleFonts.jost(
            fontSize: screenWidth * 0.042,
            color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
          ),
        ),
        const SizedBox(height: 28),

        // Start Workout Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, anim, secAnim) => WorkoutTimer(
                    workoutName: work?.workoutsName ?? 'Workout',
                    difficulty: work?.difficulty ?? 'Beginner',
                    workoutDuration: work?.duration,
                    workColor: appcolorRed,
                    restColor: appcolorgreen,
                    backgroundColor: appcolorwhite,
                    circularProgressSize: 250.0,
                  ),
                  transitionsBuilder: (_, anim, secAnim, child) =>
                      FadeTransition(opacity: anim, child: child),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: appcolorRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
            ),
            child: Text(
              'Start Workout',
              style: GoogleFonts.jost(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: appcolorwhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
