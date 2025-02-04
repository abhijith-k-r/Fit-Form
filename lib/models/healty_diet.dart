import 'package:hive_flutter/hive_flutter.dart';

part 'healty_diet.g.dart';

@HiveType(typeId: 7)
class HealtyDiet {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? healthname;

  @HiveField(2)
  String? healthdescribe;

  @HiveField(3)
  double? healthcalories;

  @HiveField(4)
  String? healthimage;

  @HiveField(5)
  DateTime? dateTime;
  
  @HiveField(6)

  bool? favorite = false;
  

  HealtyDiet({this.id,required this.healthname, required this.healthcalories, required this.healthdescribe, this.healthimage, this.dateTime,this.favorite});
}
