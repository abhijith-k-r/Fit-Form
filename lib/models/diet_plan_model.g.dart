// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet_plan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodItemsAdapter extends TypeAdapter<FoodItems> {
  @override
  final int typeId = 4;

  @override
  FoodItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodItems(
      id: fields[0] as String?,
      foodName: fields[1] as String,
      calories: fields[2] as double,
      protien: fields[3] as double,
      fat: fields[4] as double,
      carbohydrates: fields[5] as double,
      gram: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, FoodItems obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.foodName)
      ..writeByte(2)
      ..write(obj.calories)
      ..writeByte(3)
      ..write(obj.protien)
      ..writeByte(4)
      ..write(obj.fat)
      ..writeByte(5)
      ..write(obj.carbohydrates)
      ..writeByte(6)
      ..write(obj.gram);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
