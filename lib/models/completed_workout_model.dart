import 'package:hive_flutter/hive_flutter.dart';

class CompletedWorkout {
  String? id;
  String? workoutName;
  String? difficulty; // 'Beginner', 'Intermediate', 'Advanced'
  DateTime? completedAt;
  int durationSeconds;

  CompletedWorkout({
    this.id,
    this.workoutName,
    this.difficulty,
    this.completedAt,
    this.durationSeconds = 0,
  });
}

class CompletedWorkoutAdapter extends TypeAdapter<CompletedWorkout> {
  @override
  final int typeId = 8;

  @override
  CompletedWorkout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedWorkout(
      id: fields[0] as String?,
      workoutName: fields[1] as String?,
      difficulty: fields[2] as String?,
      completedAt: fields[3] as DateTime?,
      durationSeconds: (fields[4] as int?) ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedWorkout obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.workoutName)
      ..writeByte(2)
      ..write(obj.difficulty)
      ..writeByte(3)
      ..write(obj.completedAt)
      ..writeByte(4)
      ..write(obj.durationSeconds);
  }
}
