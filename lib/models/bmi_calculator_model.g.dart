// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi_calculator_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BmiInstructionAdapter extends TypeAdapter<BmiInstruction> {
  @override
  final int typeId = 5;

  @override
  BmiInstruction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BmiInstruction(
      id: fields[0] as String?,
      imagepath: fields[1] as String?,
      descripion: fields[2] as String?,
      category: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BmiInstruction obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imagepath)
      ..writeByte(2)
      ..write(obj.descripion)
      ..writeByte(3)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BmiInstructionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
