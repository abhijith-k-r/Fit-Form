import 'package:fit_form/Screens/Extracted_Screens/diet_planner.dart';
import 'package:fit_form/features/diet_planner/widgets/bmi_calculator_form.dart';
import 'package:fit_form/features/diet_planner/widgets/bmi_instruction_card.dart';
import 'package:fit_form/features/diet_planner/widgets/bmi_result_card.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:fit_form/models/bmi_calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BmiCalculatorBody extends StatelessWidget {
  final TextEditingController heightController;
  final TextEditingController weightController;
  final Box<BmiCalculate>? box;
  final List<BmiCalculate> list;
  final List<BmiInstruction> instructions;
  final Color? categoryColor;
  final VoidCallback onCalculate;
  final VoidCallback onClear;

  const BmiCalculatorBody({
    super.key,
    required this.heightController,
    required this.weightController,
    required this.box,
    required this.list,
    required this.instructions,
    required this.categoryColor,
    required this.onCalculate,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        spacing: 20,
        children: [
          const SizedBox(height: 20),
          bmiCalculatorCarousel(context, carousalItemss),
          BmiCalculatorForm(
            heightController: heightController,
            weightController: weightController,
            hasHistory: box != null && box!.isNotEmpty,
            box: box,
            onCalculate: onCalculate,
            onClear: onClear,
          ),
          BmiResultCard(bmiList: list, screenWidth: width, categoryColor: categoryColor),
          BmiInstructionList(instructions: instructions, screenWidth: width),
        ],
      ),
    );
  }
}
