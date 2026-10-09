import 'package:fit_form/features/diet_planner/data/healthy_diet_data_source.dart';
import 'package:fit_form/features/workouts/data/completed_workout_data_source.dart';
import 'package:flutter/material.dart';

class FitnessSummaryService {
  FitnessSummaryService._();

  static double? calculateBmi(String? heightCm, String? weightKg) {
    if (heightCm == null || weightKg == null) return null;
    final h = double.tryParse(heightCm);
    final w = double.tryParse(weightKg);
    if (h == null || w == null || h <= 0 || w <= 0) return null;
    final hMeters = h / 100.0;
    return w / (hMeters * hMeters);
  }

  static String getBmiCategory(double? bmi) {
    if (bmi == null) return 'Pending Details';
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Normal Weight';
    if (bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  static Color getBmiColor(double? bmi) {
    if (bmi == null) return Colors.grey;
    if (bmi < 18.5) return const Color(0xFF3B82F6);
    if (bmi < 25.0) return const Color(0xFF10B981);
    if (bmi < 30.0) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  static double getTodayDietCalories() {
    final now = DateTime.now();
    return healthyDietNotifier.value.where((d) {
      if (d.dateTime == null) return true; // legacy treated as today
      return d.dateTime!.year == now.year &&
          d.dateTime!.month == now.month &&
          d.dateTime!.day == now.day;
    }).fold<double>(0.0, (sum, d) => sum + (d.healthcalories ?? 0.0));
  }

  static Map<String, int> getTodayWorkoutStats() {
    return CompletedWorkoutDataSource.getTodayStats();
  }
}
