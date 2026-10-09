import 'package:fit_form/App_Colors/app_colors.dart';

import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/bmi_calculator.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/calorie_calculator.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/healty_diets.dart';
import 'package:flutter/material.dart';
import 'package:fit_form/main.dart';
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
                _buildMenuCard(
                  context,
                  title: 'BMI Calculator',
                  icon: Icons.trending_up_outlined,
                  isDark: isDarkMode,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BmiCalculator()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuCard(
                  context,
                  title: 'Calorie Calculator',
                  icon: Icons.calculate,
                  isDark: isDarkMode,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CalorieCalculator()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuCard(
                  context,
                  title: 'Healthy Diet',
                  icon: Icons.food_bank,
                  isDark: isDarkMode,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HealthyDietPlannerScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color.fromARGB(255, 37, 36, 36) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 28,
                color: isDark ? appcolorwhite : appcolorblack,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDark ? appcolorwhite : appcolorblack,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
