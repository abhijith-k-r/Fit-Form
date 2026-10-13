import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/diet_planner.dart';
import 'package:fit_form/features/diet_planner/data/calorie_calculator_service.dart';
import 'package:fit_form/features/diet_planner/widgets/calorie_food_list_section.dart';
import 'package:fit_form/features/diet_planner/widgets/calorie_input_form.dart';
import 'package:fit_form/functions/diet_funtions.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({super.key});

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  String? selectFoodItems;
  final TextEditingController _gramsController = TextEditingController();
  double totalCalories = 0;

  @override
  void initState() {
    super.initState();
    loadInitialData(_calc);
  }

  void _calc() {
    final foods = foodItemNotify.value;
    setState(() => totalCalories = foods.fold(0, (s, i) => s + i.calories));
  }

  Future<void> _addFood() async {
    final success = await CalorieCalculatorService.addFoodItem(
        selectFoodItems, _gramsController.text);
    if (!success) {
      if (!mounted) return;
      snackBarMessenger(context, 'Select food & enter valid grams (1-2000)', appcolorRed);
      return;
    }
    _calc();
    _gramsController.clear();
    setState(() => selectFoodItems = null);
  }

  @override
  void dispose() {
    _gramsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, isDarkMode, _) => Scaffold(
        backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
        appBar: AppBar(
          backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
          elevation: 0,
          title: Text(
            'Calorie Calculator',
            style: GoogleFonts.jost(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: isDarkMode ? appcolorwhite : appcolorblack,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              caloreCalculatorCarousel(context, carousalItems),
              CalorieInputForm(
                selectedFood: selectFoodItems,
                gramsController: _gramsController,
                onFoodChanged: (val) => setState(() => selectFoodItems = val),
                onAddFood: _addFood,
              ),
              CalorieFoodListSection(totalCalories: totalCalories, onRemoveItem: _calc),
            ],
          ),
        ),
      ),
    );
  }
}
