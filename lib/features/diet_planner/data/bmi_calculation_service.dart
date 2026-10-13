import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BmiCalculationResult {
  final String category;
  final Color color;
  const BmiCalculationResult(this.category, this.color);
}

class BmiCalculationService {
  BmiCalculationService._();

  static BmiCalculationResult? calculateAndSave({
    required String heightText,
    required String weightText,
    required Box<BmiCalculate>? box,
  }) {
    final h = double.tryParse(heightText);
    final w = double.tryParse(weightText);
    if (h == null || w == null || h <= 0 || h > 251 || w <= 0 || w > 635) {
      return null;
    }
    final bmi = w / ((h / 100) * (h / 100));
    final cat = bmi < 18.5
        ? 'UnderWeight'
        : bmi < 24.9
            ? 'Normal'
            : bmi < 29.9
                ? 'OverWeight'
                : 'Obese';
    final col = bmi < 18.5
        ? appcolorblue
        : bmi < 24.9
            ? appcolorgreen
            : bmi < 29.9
                ? appcolororang
                : appcolorRed;
    final item = BmiCalculate(
      height: h,
      weight: w,
      bmiresult: bmi,
      bmicategorry: cat,
      timestamp: DateTime.now(),
    );
    box?.add(item);
    return BmiCalculationResult(cat, col);
  }
}
