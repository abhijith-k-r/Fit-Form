import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum MealFilterPeriod { day, week, month, year, all }

class MealFilterBar extends StatelessWidget {
  const MealFilterBar({
    super.key,
    required this.selectedPeriod,
    required this.isDark,
    required this.onPeriodChanged,
    required this.onPickCustomDate,
  });

  final MealFilterPeriod selectedPeriod;
  final bool isDark;
  final ValueChanged<MealFilterPeriod> onPeriodChanged;
  final VoidCallback onPickCustomDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildChip('Today', MealFilterPeriod.day),
              const SizedBox(width: 8),
              _buildChip('This Week', MealFilterPeriod.week),
              const SizedBox(width: 8),
              _buildChip('This Month', MealFilterPeriod.month),
              const SizedBox(width: 8),
              _buildChip('This Year', MealFilterPeriod.year),
              const SizedBox(width: 8),
              _buildChip('All Time', MealFilterPeriod.all),
              const SizedBox(width: 8),
              ActionChip(
                avatar: const Icon(Icons.date_range, size: 16),
                label: Text(
                  'Pick Date',
                  style: GoogleFonts.jost(fontSize: 12),
                ),
                backgroundColor: isDark
                    ? const Color.fromARGB(255, 36, 36, 36)
                    : Colors.grey[200],
                onPressed: onPickCustomDate,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, MealFilterPeriod period) {
    final isSelected = selectedPeriod == period;
    return ChoiceChip(
      label: Text(
        label,
        style: GoogleFonts.jost(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? Colors.white
              : (isDark ? Colors.grey[300] : Colors.grey[800]),
        ),
      ),
      selected: isSelected,
      selectedColor: appcolorRed,
      backgroundColor: isDark
          ? const Color.fromARGB(255, 36, 36, 36)
          : const Color.fromARGB(255, 240, 240, 242),
      onSelected: (_) => onPeriodChanged(period),
    );
  }
}
