import 'package:fit_form/functions/diet_funtions.dart';
import 'package:fit_form/models/diet_plan_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalorieCalculatorService {
  CalorieCalculatorService._();

  static Future<bool> addFoodItem(String? selectedFood, String gramsText) async {
    final g = int.tryParse(gramsText);
    if (selectedFood == null || g == null || g <= 0 || g > 2000) {
      return false;
    }
    final f = foodItems.firstWhere((i) => i.foodName == selectedFood);
    final m = g / 100;
    final item = FoodItems(
      foodName: f.foodName,
      gram: g,
      calories: f.calories * m,
      protien: f.protien * m,
      fat: f.fat * m,
      carbohydrates: f.carbohydrates * m,
    );
    final db = await Hive.openBox<FoodItems>('foodItems');
    await db.add(item);
    foodItemNotify.value = db.values.toList().cast<FoodItems>();
    return true;
  }
}
