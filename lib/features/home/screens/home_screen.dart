import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/core/services/fitness_summary_service.dart';
import 'package:fit_form/features/home/widgets/home_app_bar.dart';
import 'package:fit_form/features/home/widgets/home_level_categories_section.dart';
import 'package:fit_form/features/home/widgets/home_metrics_summary_card.dart';
import 'package:fit_form/features/home/widgets/home_today_workouts_card.dart';
import 'package:fit_form/features/home/widgets/home_workout_carousel.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.id});
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

    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, isDarkMode, _) {
        return ValueListenableBuilder<List<Usermodel>>(
          valueListenable: userDatas,
          builder: (context, user, child) {
            if (user.isEmpty) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            final home = user.firstWhere((e) => e.id == widget.id, orElse: () => user.first);
            final bmi = FitnessSummaryService.calculateBmi(home.height, home.weight);
            final bmiCategory = FitnessSummaryService.getBmiCategory(bmi);
            final bmiColor = FitnessSummaryService.getBmiColor(bmi);

            return Scaffold(
              backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
              appBar: HomeAppBar(user: home, isDarkMode: isDarkMode),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
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
                    HomeTodayWorkoutsCard(isDarkMode: isDarkMode),
                    const SizedBox(height: 14),
                    HomeMetricsSummaryCard(
                      bmi: bmi,
                      bmiCategory: bmiCategory,
                      bmiColor: bmiColor,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 20),
                    HomeWorkoutCarousel(screenWidth: screenWidth, isDarkMode: isDarkMode),
                    const HomeLevelCategoriesSection(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
