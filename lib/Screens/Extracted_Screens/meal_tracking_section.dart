import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/widgets/meal_day_carousel_section.dart';
import 'package:fit_form/Screens/Extracted_Screens/widgets/meal_filter_bar.dart';
import 'package:fit_form/Screens/Extracted_Screens/widgets/meal_filtered_list.dart';
import 'package:fit_form/features/diet_planner/data/healthy_diet_data_source.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealTrackingSection extends StatefulWidget {
  const MealTrackingSection({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<MealTrackingSection> createState() => _MealTrackingSectionState();
}

class _MealTrackingSectionState extends State<MealTrackingSection> {
  bool _showSeeAllFilter = false;
  MealFilterPeriod _selectedPeriod = MealFilterPeriod.day;
  DateTime? _customPickedDate;

  Future<void> _pickCustomDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _customPickedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        _customPickedDate = picked;
        _selectedPeriod = MealFilterPeriod.day;
        _showSeeAllFilter = true;
      });
    }
  }

  List<HealtyDiet> _filterMeals(List<HealtyDiet> allMeals) {
    final now = DateTime.now();
    return allMeals.where((diet) {
      final itemDate = diet.dateTime ?? DateTime.now();
      if (_customPickedDate != null &&
          _selectedPeriod == MealFilterPeriod.day) {
        return itemDate.year == _customPickedDate!.year &&
            itemDate.month == _customPickedDate!.month &&
            itemDate.day == _customPickedDate!.day;
      }
      switch (_selectedPeriod) {
        case MealFilterPeriod.day:
          return itemDate.year == now.year &&
              itemDate.month == now.month &&
              itemDate.day == now.day;
        case MealFilterPeriod.week:
          final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
          final start =
              DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
          final end = start.add(const Duration(days: 7));
          return itemDate.isAfter(start.subtract(const Duration(seconds: 1))) &&
              itemDate.isBefore(end);
        case MealFilterPeriod.month:
          return itemDate.year == now.year && itemDate.month == now.month;
        case MealFilterPeriod.year:
          return itemDate.year == now.year;
        case MealFilterPeriod.all:
          return true;
      }
    }).toList();
  }

  String _getPeriodLabel() {
    if (_customPickedDate != null && _selectedPeriod == MealFilterPeriod.day) {
      return '${_customPickedDate!.day}/${_customPickedDate!.month}/${_customPickedDate!.year}';
    }
    switch (_selectedPeriod) {
      case MealFilterPeriod.day:
        return 'Today';
      case MealFilterPeriod.week:
        return 'This Week';
      case MealFilterPeriod.month:
        return 'This Month';
      case MealFilterPeriod.year:
        return 'This Year';
      case MealFilterPeriod.all:
        return 'All Time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<HealtyDiet>>(
      valueListenable: healthyDietNotifier,
      builder: (context, allDiets, _) {
        final tomorrowMeals = HealthyDietDataSource.getTomorrowMeals();
        final todayMeals = HealthyDietDataSource.getTodayMeals();
        final yesterdayMeals = HealthyDietDataSource.getYesterdayMeals();

        final tomorrowCals = HealthyDietDataSource.getTomorrowCalories();
        final todayCals = HealthyDietDataSource.getTodayCalories();
        final yesterdayCals = HealthyDietDataSource.getYesterdayCalories();

        final filteredMeals = _filterMeals(allDiets);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Toggle Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () =>
                    setState(() => _showSeeAllFilter = !_showSeeAllFilter),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: widget.isDarkMode
                        ? const Color.fromARGB(255, 34, 34, 34)
                        : const Color.fromARGB(255, 242, 242, 246),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: appcolorRed.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.tune, color: appcolorRed, size: 22),
                          const SizedBox(width: 10),
                          Text(
                            _showSeeAllFilter
                                ? 'Hide Filtered Meals'
                                : 'See All & Filter Meals',
                            style: GoogleFonts.jost(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.isDarkMode
                                  ? appcolorwhite
                                  : appcolorblack,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        _showSeeAllFilter
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: appcolorRed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // See All & Filter View
            if (_showSeeAllFilter) ...[
              MealFilterBar(
                selectedPeriod: _selectedPeriod,
                isDark: widget.isDarkMode,
                onPeriodChanged: (p) => setState(() {
                  _selectedPeriod = p;
                  _customPickedDate = null;
                }),
                onPickCustomDate: _pickCustomDate,
              ),
              const SizedBox(height: 16),
              MealFilteredList(
                filteredMeals: filteredMeals,
                periodLabel: _getPeriodLabel(),
                isDark: widget.isDarkMode,
              ),
              const SizedBox(height: 24),
              const Divider(height: 1, indent: 16, endIndent: 16),
              const SizedBox(height: 20),
            ],

            // 1. Tomorrow's Meals
            MealDayCarouselSection(
              title: "Tomorrow's Meals",
              calories: tomorrowCals,
              meals: tomorrowMeals,
              emptyMsg: 'No meals planned for tomorrow.',
              isDarkMode: widget.isDarkMode,
            ),
            const SizedBox(height: 24),

            // 2. Today's Meals
            MealDayCarouselSection(
              title: "Today's Meals",
              calories: todayCals,
              meals: todayMeals,
              emptyMsg: 'No meals logged for today yet.',
              isDarkMode: widget.isDarkMode,
            ),
            const SizedBox(height: 24),

            // 3. Yesterday's Meals
            MealDayCarouselSection(
              title: "Yesterday's Meals",
              calories: yesterdayCals,
              meals: yesterdayMeals,
              emptyMsg: 'No meals were logged yesterday.',
              isDarkMode: widget.isDarkMode,
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
