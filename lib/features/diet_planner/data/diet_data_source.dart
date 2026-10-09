// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fit_form/core/constants/app_keys.dart';
import 'package:fit_form/models/diet_plan_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Reactive notifier for the user's tracked food items in the calorie tracker.
final ValueNotifier<List<FoodItems>> foodItemNotifier =
    ValueNotifier<List<FoodItems>>([]);

/// Reactive notifier for available foods the user can select and calculate from.
final ValueNotifier<List<FoodItems>> foodCatalogueNotifier =
    ValueNotifier<List<FoodItems>>([]);

/// Default starting food catalogue used when first launching the app.
const List<Map<String, dynamic>> kDefaultFoodCatalogue = [
  {'name': 'Chicken Breast', 'calories': 165.0, 'protein': 31.0, 'fat': 3.6, 'carbs': 0.0},
  {'name': 'Salmon',         'calories': 206.0, 'protein': 22.0, 'fat': 12.0, 'carbs': 0.0},
  {'name': 'Eggs',           'calories': 155.0, 'protein': 13.0, 'fat': 11.0, 'carbs': 1.1},
  {'name': 'Almonds',        'calories': 579.0, 'protein': 21.0, 'fat': 50.0, 'carbs': 22.0},
  {'name': 'Broccoli',       'calories':  34.0, 'protein':  2.8, 'fat':  0.4, 'carbs':  7.0},
  {'name': 'Brown Rice',     'calories': 123.0, 'protein':  2.7, 'fat':  1.0, 'carbs': 25.0},
  {'name': 'Apple',          'calories':  52.0, 'protein':  0.3, 'fat':  0.2, 'carbs': 14.0},
  {'name': 'Banana',         'calories':  89.0, 'protein':  1.1, 'fat':  0.3, 'carbs': 23.0},
  {'name': 'Sweet Potato',   'calories':  86.0, 'protein':  1.6, 'fat':  0.1, 'carbs': 20.0},
  {'name': 'Spinach',        'calories':  23.0, 'protein':  2.9, 'fat':  0.4, 'carbs':  3.6},
];

/// Legacy compatibility alias.
const List<Map<String, dynamic>> kFoodCatalogue = kDefaultFoodCatalogue;

/// Returns current catalogue items list.
List<FoodItems> get catalogueFoodItems => foodCatalogueNotifier.value;

/// Hive CRUD for food catalogue and calorie tracker.
class DietDataSource {
  DietDataSource._();

  static Future<Box<FoodItems>> _logBox() =>
      Hive.openBox<FoodItems>(AppKeys.foodItemsBox);

  static Future<Box<FoodItems>> _catalogueBox() =>
      Hive.openBox<FoodItems>(AppKeys.foodCatalogueBox);

  static Future<void> initialize() async {
    if (!Hive.isAdapterRegistered(FoodItemsAdapter().typeId)) {
      Hive.registerAdapter(FoodItemsAdapter());
    }
    await _seedCatalogueIfEmpty();
    await refreshCatalogue();
    await refresh();
  }

  static Future<void> _seedCatalogueIfEmpty() async {
    final catBox = await _catalogueBox();
    if (catBox.isEmpty) {
      for (final m in kDefaultFoodCatalogue) {
        await catBox.add(FoodItems(
          foodName: m['name'] as String,
          calories: m['calories'] as double,
          protien: m['protein'] as double,
          fat: m['fat'] as double,
          carbohydrates: m['carbs'] as double,
          gram: 100,
        ));
      }
    }
  }

  // ── Food Catalogue (My Foods) ──────────────────────────────────────────

  static Future<void> refreshCatalogue() async {
    final box = await _catalogueBox();
    foodCatalogueNotifier.value = box.values.toList();
    foodCatalogueNotifier.notifyListeners();
  }

  static Future<bool> addCatalogueItem(FoodItems item) async {
    final box = await _catalogueBox();
    // Check if food already exists (case-insensitive)
    final exists = box.values.any((f) =>
        f.foodName.trim().toLowerCase() == item.foodName.trim().toLowerCase());
    if (exists) {
      return false;
    }
    await box.add(item);
    await refreshCatalogue();
    return true;
  }

  static Future<void> removeCatalogueItem(int index) async {
    final box = await _catalogueBox();
    await box.deleteAt(index);
    await refreshCatalogue();
  }

  // ── Tracked Calorie Log ───────────────────────────────────────────────

  static Future<void> refresh() async {
    final box = await _logBox();
    foodItemNotifier.value = box.values.toList();
    foodItemNotifier.notifyListeners();
  }

  static Future<void> removeAt(int index) async {
    final box = await _logBox();
    await box.deleteAt(index);
    await refresh();
  }
}
