import 'package:fit_form/models/diet_plan_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<FoodItems>> foodItemNotify = ValueNotifier([]);

Future<void> dietInitialize() async {
  if (!Hive.isAdapterRegistered(FoodItemsAdapter().typeId)) {
    Hive.registerAdapter(FoodItemsAdapter());
  }
}

Future<void> loadInitialData(Function calculateTotalCalories) async {
  final db = await Hive.openBox<FoodItems>('foodItems');
  foodItemNotify.value = db.values.toList().cast<FoodItems>();
  calculateTotalCalories();
}

Future<void> removeCalorie(int index, Function calculateTotalCalories) async {
  final db = await Hive.openBox<FoodItems>('foodItems');
  await db.deleteAt(index);
  foodItemNotify.value = db.values.toList().cast<FoodItems>();
  calculateTotalCalories();
}

Future<void> addFoodImes() async {
  final db = await Hive.openBox<FoodItems>('foodItems');

  if (db.isEmpty) {
    final foodItems = [
      FoodItems(
          foodName: 'Chicken Breast',
          calories: 165,
          protien: 31,
          fat: 3.6,
          carbohydrates: 0),
      FoodItems(
          foodName: 'Salmon',
          calories: 206,
          protien: 22,
          fat: 12,
          carbohydrates: 0),
      FoodItems(
          foodName: 'Eggs',
          calories: 155,
          protien: 13,
          fat: 11,
          carbohydrates: 1.1),
      FoodItems(
          foodName: 'Almonds',
          calories: 579,
          protien: 21,
          fat: 50,
          carbohydrates: 22),
      FoodItems(
          foodName: 'Broccoli',
          calories: 34,
          protien: 2.8,
          fat: 0.4,
          carbohydrates: 7),
      FoodItems(
          foodName: 'Brown Rice',
          calories: 123,
          protien: 2.7,
          fat: 1,
          carbohydrates: 25),
      FoodItems(
          foodName: 'Apple',
          calories: 52,
          protien: 0.3,
          fat: 0.2,
          carbohydrates: 14),
      FoodItems(
          foodName: 'Banana',
          calories: 89,
          protien: 1.1,
          fat: 0.3,
          carbohydrates: 23),
      FoodItems(
          foodName: 'Sweet Potato',
          calories: 86,
          protien: 1.6,
          fat: 0.1,
          carbohydrates: 20),
      FoodItems(
          foodName: 'Spinach',
          calories: 23,
          protien: 2.9,
          fat: 0.4,
          carbohydrates: 3.6),
    ];
    for (var item in foodItems) {
      await db.add(item);
    }
  }

  foodItemNotify.value = db.values.toList().cast<FoodItems>();
}

// ! For Calories Calculator

final List<FoodItems> foodItems = [
  FoodItems(
      foodName: 'Chicken Breast',
      calories: 165,
      protien: 31,
      fat: 3.6,
      carbohydrates: 0),
  FoodItems(
      foodName: 'Salmon',
      calories: 206,
      protien: 22,
      fat: 12,
      carbohydrates: 0),
  FoodItems(
      foodName: 'Eggs',
      calories: 155,
      protien: 13,
      fat: 11,
      carbohydrates: 1.1),
  FoodItems(
      foodName: 'Almonds',
      calories: 579,
      protien: 21,
      fat: 50,
      carbohydrates: 22),
  FoodItems(
      foodName: 'Broccoli',
      calories: 34,
      protien: 2.8,
      fat: 0.4,
      carbohydrates: 7),
  FoodItems(
      foodName: 'Brown Rice',
      calories: 123,
      protien: 2.7,
      fat: 1,
      carbohydrates: 25),
  FoodItems(
      foodName: 'Apple',
      calories: 52,
      protien: 0.3,
      fat: 0.2,
      carbohydrates: 14),
  FoodItems(
      foodName: 'Banana',
      calories: 89,
      protien: 1.1,
      fat: 0.3,
      carbohydrates: 23),
  FoodItems(
      foodName: 'Sweet Potato',
      calories: 86,
      protien: 1.6,
      fat: 0.1,
      carbohydrates: 20),
  FoodItems(
      foodName: 'Spinach',
      calories: 23,
      protien: 2.9,
      fat: 0.4,
      carbohydrates: 3.6),
];
