import 'package:hive_flutter/hive_flutter.dart';

part 'bmi_calculator_model.g.dart';

@HiveType(typeId: 5)
class BmiInstruction {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? imagepath;

  @HiveField(2)
  String? descripion;

  @HiveField(3)
  String? category;

  BmiInstruction(
      {this.id,
      required this.imagepath,
      required this.descripion,
      required this.category});
}
