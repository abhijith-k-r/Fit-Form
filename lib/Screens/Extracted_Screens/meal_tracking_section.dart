// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Inside_Screens/healthy_show.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum DietFilterType { all, day, week, month, year }

class MealTrackingSection extends StatefulWidget {
  const MealTrackingSection({super.key});

  @override
  State<MealTrackingSection> createState() => _MealTrackingSectionState();
}

class _MealTrackingSectionState extends State<MealTrackingSection> {
  DietFilterType _selectedFilter = DietFilterType.all;
  DateTime _selectedFilterDate = DateTime.now();
  bool _showSeeAllFilter = false;

  bool _isSameDay(DateTime? a, DateTime b) {
    if (a == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isSameWeek(DateTime? a, DateTime b) {
    if (a == null) return false;
    final startOfWeek = b.subtract(Duration(days: b.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    return a.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        a.isBefore(endOfWeek);
  }

  bool _isSameMonth(DateTime? a, DateTime b) {
    if (a == null) return false;
    return a.year == b.year && a.month == b.month;
  }

  bool _isSameYear(DateTime? a, DateTime b) {
    if (a == null) return false;
    return a.year == b.year;
  }

  List<HealtyDiet> _getFilteredList(List<HealtyDiet> allDiets) {
    switch (_selectedFilter) {
      case DietFilterType.day:
        return allDiets
            .where((d) => _isSameDay(d.dateTime ?? DateTime.now(), _selectedFilterDate))
            .toList();
      case DietFilterType.week:
        return allDiets
            .where((d) => _isSameWeek(d.dateTime ?? DateTime.now(), DateTime.now()))
            .toList();
      case DietFilterType.month:
        return allDiets
            .where((d) => _isSameMonth(d.dateTime ?? DateTime.now(), DateTime.now()))
            .toList();
      case DietFilterType.year:
        return allDiets
            .where((d) => _isSameYear(d.dateTime ?? DateTime.now(), DateTime.now()))
            .toList();
      case DietFilterType.all:
        return allDiets;
    }
  }

  Future<void> _pickFilterDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedFilterDate,
      firstDate: DateTime.now().subtract(const Duration(days: 730)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedFilterDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = isDark.value;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));

    return ValueListenableBuilder<List<HealtyDiet>>(
      valueListenable: healthyNotify,
      builder: (context, diets, child) {
        // Group diets into Tomorrow, Today, Yesterday
        final tomorrowMeals = diets.where((d) {
          if (d.dateTime == null) return false;
          return _isSameDay(d.dateTime, tomorrow);
        }).toList();

        final todayMeals = diets.where((d) {
          if (d.dateTime == null) return true; // fallback legacy to today
          return _isSameDay(d.dateTime, today);
        }).toList();

        final yesterdayMeals = diets.where((d) {
          if (d.dateTime == null) return false;
          return _isSameDay(d.dateTime, yesterday);
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // 1. TOMORROW'S MEALS
            _buildDayMealSection(
              title: "Tomorrow's Meals",
              meals: tomorrowMeals,
              isDark: isDarkMode,
              emptyMessage: "No meals planned for tomorrow. Tap + to plan.",
            ),

            const SizedBox(height: 20),

            // 2. TODAY'S MEALS
            _buildDayMealSection(
              title: "Today's Meals",
              meals: todayMeals,
              isDark: isDarkMode,
              emptyMessage: "No meals logged for today. Tap + to add.",
            ),

            const SizedBox(height: 20),

            // 3. YESTERDAY'S MEALS
            _buildDayMealSection(
              title: "Yesterday's Meals",
              meals: yesterdayMeals,
              isDark: isDarkMode,
              emptyMessage: "No meals recorded for yesterday.",
            ),

            const SizedBox(height: 24),

            // SEE ALL & FILTER BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _showSeeAllFilter = !_showSeeAllFilter;
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromARGB(255, 34, 34, 34)
                        : const Color.fromARGB(255, 242, 242, 246),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: appcolorRed.withOpacity(0.3),
                    ),
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
                              color: isDarkMode ? appcolorwhite : appcolorblack,
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

            // EXPANDED FILTER SECTION
            if (_showSeeAllFilter) ...[
              const SizedBox(height: 16),
              _buildFilterControls(isDarkMode),
              const SizedBox(height: 12),
              _buildFilteredResultsSection(diets, isDarkMode),
            ],

            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Widget _buildDayMealSection({
    required String title,
    required List<HealtyDiet> meals,
    required bool isDark,
    required String emptyMessage,
  }) {
    final double dayCalories = meals.fold<double>(
      0.0,
      (sum, item) => sum + (item.healthcalories ?? 0.0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row with Total Calories aligned to END
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? appcolorwhite : appcolorblack,
                ),
              ),
              // MainAxis alignment end - total calories
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    size: 18,
                    color: appcolorRed,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${dayCalories.toStringAsFixed(1)} kcal',
                    style: GoogleFonts.jost(
                      fontSize: 16,
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

        // Horizontal List of Meals
        if (meals.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color.fromARGB(255, 28, 28, 28)
                    : const Color.fromARGB(255, 246, 246, 248),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white10 : Colors.black.withOpacity(0.04),
                ),
              ),
              child: Center(
                child: Text(
                  emptyMessage,
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
              itemCount: meals.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final diet = meals[index];
                return _buildMealHorizontalCard(diet, isDark);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildMealHorizontalCard(HealtyDiet diet, bool isDark) {
    final favoriteNotifier = ValueNotifier<bool>(diet.favorite ?? false);

    return Container(
      width: 175,
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 34, 34, 34)
            : const Color.fromARGB(255, 246, 246, 248),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Favorite Icon Overlay
          Stack(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, anim, secAnim) =>
                        HealthyDietShowScreen(diet: diet),
                    transitionsBuilder: (_, anim, secAnim, child) =>
                        FadeTransition(opacity: anim, child: child),
                  ),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: diet.healthimage != null &&
                          File(diet.healthimage!).existsSync()
                      ? Image.file(
                          File(diet.healthimage!),
                          width: 175,
                          height: 110,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'asset/Diet_Plans_Images/HealthyDiet2.jpg',
                          width: 175,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: ValueListenableBuilder<bool>(
                  valueListenable: favoriteNotifier,
                  builder: (context, isFavorite, _) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(6),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFavorite ? appcolorpink : Colors.white,
                        ),
                        onPressed: () async {
                          favoriteNotifier.value = !isFavorite;
                          diet.favorite = favoriteNotifier.value;
                          await editHealthyDiet(diet.id!, diet);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diet.healthname ?? 'Meal',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.jost(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? appcolorwhite : appcolorblack,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.local_fire_department,
                        size: 14, color: appcolorRed),
                    const SizedBox(width: 2),
                    Text(
                      '${(diet.healthcalories ?? 0).toStringAsFixed(1)} kcal',
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: appcolorRed,
                      ),
                    ),
                  ],
                ),
                if (diet.dateTime != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${diet.dateTime!.day}/${diet.dateTime!.month}',
                    style: GoogleFonts.jost(
                      fontSize: 11,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterControls(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(DietFilterType.all, 'All', isDark),
                const SizedBox(width: 8),
                _buildFilterChip(DietFilterType.day, 'Day', isDark),
                const SizedBox(width: 8),
                _buildFilterChip(DietFilterType.week, 'Week-wise', isDark),
                const SizedBox(width: 8),
                _buildFilterChip(DietFilterType.month, 'Month', isDark),
                const SizedBox(width: 8),
                _buildFilterChip(DietFilterType.year, 'Year', isDark),
              ],
            ),
          ),
          if (_selectedFilter == DietFilterType.day) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Selected: ${_selectedFilterDate.day}/${_selectedFilterDate.month}/${_selectedFilterDate.year}',
                  style: GoogleFonts.jost(
                    fontSize: 14,
                    color: isDark ? appcolorwhite : appcolorblack,
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _pickFilterDate,
                  icon: const Icon(Icons.calendar_today, size: 14),
                  label: const Text('Change Day'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip(DietFilterType type, String label, bool isDark) {
    final isSelected = _selectedFilter == type;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: appcolorRed,
      labelStyle: GoogleFonts.jost(
        color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = type;
          });
        }
      },
    );
  }

  Widget _buildFilteredResultsSection(List<HealtyDiet> allDiets, bool isDark) {
    final filtered = _getFilteredList(allDiets);
    final double totalFilteredCalories = filtered.fold<double>(
      0.0,
      (sum, item) => sum + (item.healthcalories ?? 0.0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total filtered calories header row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filtered Meals (${filtered.length})',
                style: GoogleFonts.jost(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? appcolorwhite : appcolorblack,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Period Total: ',
                    style: GoogleFonts.jost(
                      fontSize: 14,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  Text(
                    '${totalFilteredCalories.toStringAsFixed(1)} kcal',
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

        // Horizontal list of filtered meals
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color.fromARGB(255, 28, 28, 28)
                    : const Color.fromARGB(255, 246, 246, 248),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'No meals found for the selected filter period.',
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
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                return _buildMealHorizontalCard(filtered[index], isDark);
              },
            ),
          ),
      ],
    );
  }
}
