// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi_calculate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BmiCalculateAdapter extends TypeAdapter<BmiCalculate> {
  @override
  final int typeId = 6;

  @override
  BmiCalculate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BmiCalculate(
      id: fields[0] as String?,
      height: fields[1] as double?,
      weight: fields[2] as double?,
      bmiresult: fields[3] as double?,
      bmicategorry: fields[4] as String?,
      timestamp: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BmiCalculate obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.bmiresult)
      ..writeByte(4)
      ..write(obj.bmicategorry)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BmiCalculateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
