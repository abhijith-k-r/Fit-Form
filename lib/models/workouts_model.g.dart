// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutsModelAdapter extends TypeAdapter<WorkoutsModel> {
  @override
  final int typeId = 2;

  @override
  WorkoutsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutsModel(
      id: fields[0] as String?,
      workoutsName: fields[1] as String?,
      woroutSteps: fields[4] as String?,
      benifits: fields[3] as String?,
      workoutsImage: fields[2] as String?,
      duration: fields[7] as String?,
      numberOfSets: fields[5] as String?,
      reps: fields[6] as String?,
      workoutvideo: fields[8] as String?,
      difficulty: fields[9] as String?,
      favorite: fields[10] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutsModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.workoutsName)
      ..writeByte(2)
      ..write(obj.workoutsImage)
      ..writeByte(3)
      ..write(obj.benifits)
      ..writeByte(4)
      ..write(obj.woroutSteps)
      ..writeByte(5)
      ..write(obj.numberOfSets)
      ..writeByte(6)
      ..write(obj.reps)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.workoutvideo)
      ..writeByte(9)
      ..write(obj.difficulty)
      ..writeByte(10)
      ..write(obj.favorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
