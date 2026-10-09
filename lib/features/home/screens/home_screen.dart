import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/homescreen_profile.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/Screens/Extracted_Screens/level_categories.dart';
import 'package:fit_form/Screens/Inside_Screens/advaced_levels.dart';
import 'package:fit_form/Screens/Inside_Screens/beginner_levels.dart';
import 'package:fit_form/Screens/Inside_Screens/intermediate_levels.dart';
import 'package:fit_form/core/services/fitness_summary_service.dart';
import 'package:fit_form/features/diet_planner/data/healthy_diet_data_source.dart';
import 'package:fit_form/features/workouts/data/completed_workout_data_source.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.id,
  });

  final String? id;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = isDark.value;

    return ValueListenableBuilder<List<Usermodel>>(
      valueListenable: userDatas,
      builder: (context, user, child) {
        if (user.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final home = user.firstWhere(
          (elements) => elements.id == widget.id,
          orElse: () => user.first,
        );

        final bmi = FitnessSummaryService.calculateBmi(
          home.height,
          home.weight,
        );
        final bmiCategory = FitnessSummaryService.getBmiCategory(bmi);
        final bmiColor = FitnessSummaryService.getBmiColor(bmi);

        return Scaffold(
          backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
          appBar: AppBar(
            backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              'Hello ${home.fullName ?? "Champ"} !',
              style: GoogleFonts.fredoka(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
            actions: [
              InkWell(
                onTap: () => show_HomeScree_Popup_Profile(context, home.id),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: appcolorRed,
                  backgroundImage: home.imagePath != null &&
                          File(home.imagePath!).existsSync()
                      ? FileImage(File(home.imagePath!))
                      : null,
                  child: (home.imagePath == null ||
                          !File(home.imagePath!).existsSync())
                      ? Icon(
                          Icons.person,
                          color: appcolorwhite,
                          size: 22,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // Tagline
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'FitForm is your ultimate companion\nfor a healthier & stronger lifestyle.',
                    style: GoogleFonts.jost(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // TODAY'S COMPLETED WORKOUTS CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ValueListenableBuilder(
                    valueListenable: completedWorkoutNotifier,
                    builder: (context, _, __) {
                      final stats =
                          FitnessSummaryService.getTodayWorkoutStats();
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
                                ? [
                                    const Color(0xFF2C1810),
                                    const Color(0xFF1E1E1E),
                                  ]
                                : [
                                    const Color(0xFFFFECEB),
                                    const Color(0xFFFFF7F6),
                                  ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: appcolorRed.withOpacity(0.25),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: appcolorRed.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                        color: isDarkMode
                                            ? appcolorwhite
                                            : appcolorblack,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: appcolorRed.withOpacity(0.15),
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

                            // Breakdown chips: Beginner, Intermediate, Advanced
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                _buildLevelDoneChip(
                                  level: 'Beginner',
                                  count: beginnerDone,
                                  accentColor: const Color(0xFF10B981),
                                  isDark: isDarkMode,
                                ),
                                _buildLevelDoneChip(
                                  level: 'Intermediate',
                                  count: intermediateDone,
                                  accentColor: const Color(0xFFF59E0B),
                                  isDark: isDarkMode,
                                ),
                                _buildLevelDoneChip(
                                  level: 'Advanced',
                                  count: advancedDone,
                                  accentColor: const Color(0xFFEF4444),
                                  isDark: isDarkMode,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),

                // ROW: BMI STAT CARD & TODAY'S CALORIES CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // Current BMI Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color.fromARGB(255, 34, 34, 34)
                                : const Color.fromARGB(255, 246, 246, 248),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: bmiColor.withOpacity(0.3),
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
                                bmi != null
                                    ? bmi.toStringAsFixed(1)
                                    : 'Not Set',
                                style: GoogleFonts.fredoka(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? appcolorwhite
                                      : appcolorblack,
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

                      // Today's Calories Card
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
                                  color: appcolorRed.withOpacity(0.2),
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
                                      color: isDarkMode
                                          ? appcolorwhite
                                          : appcolorblack,
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
                ),
                const SizedBox(height: 20),

                // CATEGORIES HEADER & CAROUSEL
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Categories',
                    style: GoogleFonts.fredoka(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? appcolorwhite : appcolorblack,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CarouselSlider.builder(
                  itemCount: horizontalContainerItems.length,
                  itemBuilder: (context, index, realIndex) {
                    final adding = horizontalContainerItems[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: adding['image'],
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: LinearColors(
                              appcoloryellow,
                              appcolorRed,
                              adding['name'],
                              22,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: screenWidth * 0.4,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    viewportFraction: 0.8,
                  ),
                ),

                // TRAININGS HEADER & LEVEL CARDS
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 12),
                  child: workoutsection(
                    context,
                    Icons.sports_handball_sharp,
                    'Trainings',
                  ),
                ),
                HomeLevels(
                  context,
                  () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const BeginnerLevels(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  'Beginner',
                  'asset/Work_Outs_Images/beginnerNew.jpg',
                ),
                const SizedBox(height: 10),
                HomeLevels(
                  context,
                  () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const IntermediateLevels(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  'Intermediate',
                  'asset/Work_Outs_Images/intermediatNewone.jpg',
                ),
                const SizedBox(height: 10),
                HomeLevels(
                  context,
                  () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AdvancedLevels(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  'Advaced',
                  'asset/Work_Outs_Images/AdvancedAi.webp',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLevelDoneChip({
    required String level,
    required int count,
    required Color accentColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 36, 36, 36)
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accentColor.withOpacity(0.35),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                level,
                style: GoogleFonts.jost(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey[300] : Colors.grey[700],
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
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
