import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Inside_Screens/widgets/workout_details_section.dart';
import 'package:fit_form/Screens/Inside_Screens/widgets/workout_header_sliver.dart';
import 'package:fit_form/Screens/Inside_Screens/widgets/workout_mx_player.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';

class ShowWorkouts extends StatelessWidget {
  const ShowWorkouts({super.key, this.work});

  final WorkoutsModel? work;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = isDark.value;

    return Scaffold(
      backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
      body: CustomScrollView(
        slivers: [
          // 1. Pinned Sliver App Bar with Exercise Background Image
          WorkoutHeaderSliver(work: work, isDarkMode: isDarkMode),

          // 2. Body: MX Player & Workout Instructions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Interactive MX-Player style Video Player
                  WorkoutMxPlayer(
                    videoPath: work?.workoutvideo,
                    isDarkMode: isDarkMode,
                  ),
                  const SizedBox(height: 20),

                  // Workout Metadata, Benefits, Instructions, Timer Button
                  WorkoutDetailsSection(
                    work: work,
                    isDarkMode: isDarkMode,
                    screenWidth: screenWidth,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
