import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/widgets/meal_horizontal_card.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealFilteredList extends StatelessWidget {
  const MealFilteredList({
    super.key,
    required this.filteredMeals,
    required this.periodLabel,
    required this.isDark,
  });

  final List<HealtyDiet> filteredMeals;
  final String periodLabel;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final totalCalories = filteredMeals.fold<double>(
      0.0,
      (sum, item) => sum + (item.healthcalories ?? 0.0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing: $periodLabel',
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? appcolorwhite : appcolorblack,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Period Total: ',
                        style: GoogleFonts.jost(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          '${totalCalories.toStringAsFixed(1)} kcal',
                          style: GoogleFonts.jost(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: appcolorRed,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (filteredMeals.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color.fromARGB(255, 30, 30, 30)
                    : const Color.fromARGB(255, 245, 245, 247),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'No meals found for this period.',
                  style: GoogleFonts.jost(
                    fontSize: 14,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
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
              itemCount: filteredMeals.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                return MealHorizontalCard(
                  diet: filteredMeals[index],
                  isDark: isDark,
                );
              },
            ),
          ),
      ],
    );
  }
}
