import 'package:hive_flutter/hive_flutter.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 1)
class Usermodel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? fullName;

  @HiveField(2)
  final String? email;

  @HiveField(3)
  final String? password;

  @HiveField(4)
   String? age;

  @HiveField(5)
   String? weight;

  @HiveField(6)
   String? height;

  @HiveField(7)
   String? imagePath;

  @HiveField(8)
  bool isLog;

  Usermodel(
      {this.fullName,
      this.email,
      this.password,
      this.age,
      this.height,
      this.weight,
      this.imagePath,
      required this.isLog,
      this.id});

  save() {}
}
