library;

// Legacy compatibility shim.
/// Diet logic has moved to:
///   lib/features/diet_planner/data/diet_data_source.dart
///   lib/features/diet_planner/data/healthy_diet_data_source.dart

export 'package:fit_form/features/diet_planner/data/diet_data_source.dart'
    show DietDataSource, foodItemNotifier, foodCatalogueNotifier, catalogueFoodItems;

import 'package:fit_form/features/diet_planner/data/diet_data_source.dart';
import 'package:fit_form/models/diet_plan_model.dart';

/// Old notifier names.
final foodItemNotify = foodItemNotifier;
final foodCatalogueNotify = foodCatalogueNotifier;

/// Dynamic food list — now returns live catalogueFoodItems.
List<FoodItems> get foodItems => catalogueFoodItems;

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
