import 'package:hive_flutter/hive_flutter.dart';

part 'bmi_calculate.g.dart';

@HiveType(typeId: 6)
class BmiCalculate {
  @HiveField(0)
  String? id;

  @HiveField(1)
  double? height;

  @HiveField(2)
  double? weight;

  @HiveField(3)
  double? bmiresult;

  @HiveField(4)
  String? bmicategorry;

  @HiveField(5)
  DateTime? timestamp;

  BmiCalculate(
      {this.id,
      this.height,
      this.weight,
      this.bmiresult,
      this.bmicategorry,
      this.timestamp});
}
