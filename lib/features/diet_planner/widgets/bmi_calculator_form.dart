import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/delet_funcion.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BmiCalculatorForm extends StatelessWidget {
  const BmiCalculatorForm({
    super.key,
    required this.heightController,
    required this.weightController,
    required this.hasHistory,
    required this.box,
    required this.onCalculate,
    required this.onClear,
  });

  final TextEditingController heightController;
  final TextEditingController weightController;
  final bool hasHistory;
  final Box<BmiCalculate>? box;
  final VoidCallback onCalculate;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bmiTextfield(heightController, 'height in cm', const Icon(Icons.trending_up)),
        const SizedBox(height: 16),
        bmiTextfield(weightController, 'weight in kg', const Icon(Icons.line_weight)),
        const SizedBox(height: 16),
        hasHistory && box != null
            ? textButton(() => calculateDelet(context, box!, onClear), "Clear BMI", EdgeInsets.zero, appcolorRed)
            : textButton(onCalculate, 'Calculate', EdgeInsets.zero, appcolorgreen),
      ],
    );
  }
}
