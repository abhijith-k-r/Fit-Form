import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/bmi_calculator.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/calorie_calculator.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/healty_diets.dart';
import 'package:fit_form/features/diet_planner/widgets/diet_menu_card.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DietTrackMenuScreen extends StatelessWidget {
  const DietTrackMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDark,
      builder: (context, bool isDarkMode, child) {
        return Scaffold(
          backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
          appBar: AppBar(
            backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
            elevation: 0,
            iconTheme: IconThemeData(
              color: isDarkMode ? appcolorwhite : appcolorblack,
            ),
            title: Text(
              'Diet Track',
              style: GoogleFonts.jost(
                color: isDarkMode ? appcolorwhite : appcolorblack,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DietMenuCard(
                  title: 'BMI Calculator',
                  icon: Icons.trending_up_outlined,
                  isDark: isDarkMode,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BmiCalculator()),
                  ),
                ),
                const SizedBox(height: 16),
                DietMenuCard(
                  title: 'Calorie Calculator',
                  icon: Icons.calculate,
                  isDark: isDarkMode,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CalorieCalculator()),
                  ),
                ),
                const SizedBox(height: 16),
                DietMenuCard(
                  title: 'Healthy Diet',
                  icon: Icons.food_bank,
                  isDark: isDarkMode,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HealthyDietPlannerScreen()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
