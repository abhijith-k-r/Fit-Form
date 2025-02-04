// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsermodelAdapter extends TypeAdapter<Usermodel> {
  @override
  final int typeId = 1;

  @override
  Usermodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Usermodel(
      fullName: fields[1] as String?,
      email: fields[2] as String?,
      password: fields[3] as String?,
      age: fields[4] as String?,
      height: fields[6] as String?,
      weight: fields[5] as String?,
      imagePath: fields[7] as String?,
      isLog: fields[8] as bool,
      id: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Usermodel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.imagePath)
      ..writeByte(8)
      ..write(obj.isLog);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsermodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
