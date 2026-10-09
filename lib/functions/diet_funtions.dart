library;

// Legacy compatibility shim.
/// Diet logic has moved to:
///   lib/features/diet_planner/data/diet_data_source.dart
///   lib/features/diet_planner/data/healthy_diet_data_source.dart

export 'package:fit_form/features/diet_planner/data/diet_data_source.dart'
    show DietDataSource, foodItemNotifier, catalogueFoodItems;

import 'package:fit_form/features/diet_planner/data/diet_data_source.dart';
import 'package:fit_form/models/diet_plan_model.dart';

/// Old notifier name.
final foodItemNotify = foodItemNotifier;

/// Old food list — now built from catalogueFoodItems to avoid duplication.
final List<FoodItems> foodItems = catalogueFoodItems;

Future<void> dietInitialize() => DietDataSource.initialize();
Future<void> addFoodImes() => DietDataSource.initialize();
Future<void> loadInitialData(Function calculateTotalCalories) async {
  await DietDataSource.refresh();
  calculateTotalCalories();
}
Future<void> removeCalorie(int index, Function calculateTotalCalories) async {
  await DietDataSource.removeAt(index);
  calculateTotalCalories();
}
