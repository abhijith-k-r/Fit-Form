import 'package:hive_flutter/hive_flutter.dart';

part 'diet_plan_model.g.dart';

@HiveType(typeId: 4)
class FoodItems {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String foodName;

  @HiveField(2)
  final double calories;

  @HiveField(3)
  final double protien;

  @HiveField(4)
  final double fat;

  @HiveField(5)
  final double carbohydrates;

  @HiveField(6)
  final dynamic gram;

  FoodItems(
      {this.id,
      required this.foodName,
      required this.calories,
      required this.protien,
      required this.fat,
      required this.carbohydrates,
      this.gram});
}
