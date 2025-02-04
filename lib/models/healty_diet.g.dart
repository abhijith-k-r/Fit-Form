// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'healty_diet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealtyDietAdapter extends TypeAdapter<HealtyDiet> {
  @override
  final int typeId = 7;

  @override
  HealtyDiet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealtyDiet(
      id: fields[0] as String?,
      healthname: fields[1] as String?,
      healthcalories: fields[3] as double?,
      healthdescribe: fields[2] as String?,
      healthimage: fields[4] as String?,
      dateTime: fields[5] as DateTime?,
      favorite: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HealtyDiet obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.healthname)
      ..writeByte(2)
      ..write(obj.healthdescribe)
      ..writeByte(3)
      ..write(obj.healthcalories)
      ..writeByte(4)
      ..write(obj.healthimage)
      ..writeByte(5)
      ..write(obj.dateTime)
      ..writeByte(6)
      ..write(obj.favorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealtyDietAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
