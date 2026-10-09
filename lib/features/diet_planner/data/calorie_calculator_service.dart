import 'package:fit_form/core/constants/app_keys.dart';
import 'package:fit_form/features/diet_planner/data/diet_data_source.dart';
import 'package:fit_form/models/diet_plan_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalorieCalculatorService {
  CalorieCalculatorService._();

  static Future<bool> addFoodItem(String? selectedFood, String gramsText) async {
    final g = int.tryParse(gramsText);
    if (selectedFood == null || g == null || g <= 0 || g > 2000) {
      return false;
    }
    final catalogue = foodCatalogueNotifier.value;
    final index = catalogue.indexWhere((i) => i.foodName == selectedFood);
    if (index == -1) {
      return false;
    }
    final f = catalogue[index];
    final m = g / 100;
    final item = FoodItems(
      foodName: f.foodName,
      gram: g,
      calories: f.calories * m,
      protien: f.protien * m,
      fat: f.fat * m,
      carbohydrates: f.carbohydrates * m,
    );
    final db = await Hive.openBox<FoodItems>(AppKeys.foodItemsBox);
    await db.add(item);
    await DietDataSource.refresh();
    return true;
  }
}
