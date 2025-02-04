import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/diet_planner.dart';
import 'package:fit_form/functions/diet_funtions.dart';
import 'package:fit_form/models/diet_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({super.key});

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  String? selectFoodItems;
  final TextEditingController _gramsController = TextEditingController();

  List<FoodItems> selectedFoods = [];
  double totalCalories = 0;

  @override
  void initState() {
    super.initState();
    loadInitialData(calculateTotalCalories);
  }

  void calculateTotalCalories() {
    final foods = foodItemNotify.value;
    totalCalories = foods.fold<double>(0, (sum, item) => sum + item.calories);
    setState(() {});
  }

  void addSelectedFood() async {
    if (selectFoodItems != null && _gramsController.text.isNotEmpty) {
      // Validate grams input
      final gramsText = _gramsController.text;
      if (!RegExp(r'^\d+$').hasMatch(gramsText)) {
        snackBarMessenger(
          context,
          'Please enter a valid number for grams',
          appcolorRed,
        );
        return;
      }

      final grams = int.parse(gramsText);
      if (grams <= 0 || grams > 2000) {
        snackBarMessenger(
          context,
          'Please enter grams between 1 and 2000',
          appcolorRed,
        );
        return;
      }

      final foodItem = foodItems.firstWhere(
        (item) => item.foodName == selectFoodItems,
      );

      final multiplier = grams / 100;

      final selectedFood = FoodItems(
        foodName: foodItem.foodName,
        gram: grams,
        calories: foodItem.calories * multiplier,
        protien: foodItem.protien * multiplier,
        fat: foodItem.fat * multiplier,
        carbohydrates: foodItem.carbohydrates * multiplier,
      );

      final db = await Hive.openBox<FoodItems>('foodItems');
      await db.add(selectedFood);

      foodItemNotify.value = db.values.toList().cast<FoodItems>();
      calculateTotalCalories();
      _gramsController.clear();
      setState(() {
        selectFoodItems = null;
      });
    } else {
      snackBarMessenger(
        context,
        'Please select food item and enter grams',
        appcolorRed,
      );
    }
  }

  @override
  void dispose() {
    _gramsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calorie Calculator',
            style: GoogleFonts.jost(fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const SizedBox(height: 20),
              caloreCalculatorCarousel(context, carousalItems),
              Padding(
                padding: const EdgeInsets.all(25),
                child: DropdownButtonFormField<String>(
                  value: selectFoodItems,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  ),
                  items: foodItems.map((FoodItems item) {
                    return DropdownMenuItem<String>(
                      value: item.foodName,
                      alignment: AlignmentDirectional.center,
                      child: Text(item.foodName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectFoodItems = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
                child: TextFormField(
                  controller: _gramsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter grams (1-2000)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextButton(
                  onPressed: addSelectedFood,
                  child: Text(
                    'CALORIES',
                    style: GoogleFonts.joan(
                      color: appcolorRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: appcolorRed.withOpacity(0.1),
                  ),
                  child: ListTile(
                    title: Text(
                      'Total Calories: ${totalCalories.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                  child: ValueListenableBuilder<List<FoodItems>>(
                      valueListenable: foodItemNotify,
                      builder: (context, List<FoodItems> foods, child) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: foods.length,
                            itemBuilder: (context, index) {
                              final food = foods[index];
                              return Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: appcolorRed.withOpacity(0.1),
                                    ),
                                    child: ListTile(
                                        onTap: () async {
                                          bool? shouldDelete =
                                              await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                              title: const Text(
                                                                'Are you Sure\n Remove this?',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              actions: [
                                                                Center(
                                                                    child: Column(
                                                                        children: [
                                                                      TextButton(
                                                                          onPressed: () => Navigator.pop(
                                                                              context,
                                                                              false),
                                                                          child: Text(
                                                                              'Cancel',
                                                                              style: GoogleFonts.jost(fontWeight: FontWeight.bold, fontSize: 15))),
                                                                      TextButton(
                                                                          onPressed: () => Navigator.pop(
                                                                              context,
                                                                              true),
                                                                          child:
                                                                              Text(
                                                                            'Remove',
                                                                            style: GoogleFonts.jost(
                                                                                color: appcolorRed,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 15),
                                                                          ))
                                                                    ]))
                                                              ]));

                                          if (shouldDelete == true) {
                                            await removeCalorie(
                                                index, calculateTotalCalories);
                                          }
                                        },
                                        title: Text(
                                          food.foodName,
                                          style: GoogleFonts.jost(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            'Quantity: ${food.gram} grams || '
                                            'Calories: ${food.calories.toStringAsFixed(2)} kcal || '
                                            'Protein: ${food.protien.toStringAsFixed(2)} g || '
                                            'Fat: ${food.fat.toStringAsFixed(2)} g || '
                                            'Carbs: ${food.carbohydrates.toStringAsFixed(2)} g',
                                            style: GoogleFonts.jost()))),
                              );
                            });
                      }))
            ])));
  }
}
