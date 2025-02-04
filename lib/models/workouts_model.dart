import 'package:hive_flutter/hive_flutter.dart';

part 'workouts_model.g.dart';

@HiveType(typeId: 2)
class WorkoutsModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? workoutsName;

  @HiveField(2)
  String? workoutsImage;

  @HiveField(3)
  String? benifits;

  @HiveField(4)
  String? woroutSteps;

  @HiveField(5)
  String? numberOfSets;

  @HiveField(6)
  String? reps;

  @HiveField(7)
  String? duration;

  @HiveField(8)
  String? workoutvideo;

  @HiveField(9)
  String? difficulty;

  @HiveField(10)
  bool? favorite = false;

  WorkoutsModel(
      {this.id,
      this.workoutsName,
      this.woroutSteps,
      this.benifits,
      this.workoutsImage,
      this.duration,
      this.numberOfSets,
      this.reps,
      this.workoutvideo,
      this.difficulty,
      this.favorite});
}
