import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/widgets/meal_horizontal_card.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealDayCarouselSection extends StatelessWidget {
  const MealDayCarouselSection({
    super.key,
    required this.title,
    required this.calories,
    required this.meals,
    required this.emptyMsg,
    required this.isDarkMode,
  });

  final String title;
  final double calories;
  final List<HealtyDiet> meals;
  final String emptyMsg;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.fredoka(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? appcolorwhite : appcolorblack,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total: ',
                    style: GoogleFonts.jost(
                      fontSize: 14,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  Text(
                    '${calories.toStringAsFixed(1)} kcal',
                    style: GoogleFonts.jost(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: appcolorRed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (meals.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color.fromARGB(255, 28, 28, 28)
                    : const Color.fromARGB(255, 246, 246, 248),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDarkMode
                      ? Colors.white10
                      : Colors.black.withValues(alpha: 0.04),
                ),
              ),
              child: Center(
                child: Text(
                  emptyMsg,
                  style: GoogleFonts.jost(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            ),
          )
        else
          SizedBox(
            height: 220,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) =>
                  MealHorizontalCard(diet: meals[index], isDark: isDarkMode),
            ),
          ),
      ],
    );
  }
}
