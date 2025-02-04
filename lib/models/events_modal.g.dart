// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventsAdapter extends TypeAdapter<Events> {
  @override
  final int typeId = 3;

  @override
  Events read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Events(
      id: fields[0] as String?,
      title: fields[1] as String?,
      contents: fields[2] as String?,
      imagepath: fields[3] as String?,
      check: fields[4] as bool?,
      date: fields[5] as DateTime?,
      workout: (fields[6] as Map?)?.cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Events obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.contents)
      ..writeByte(3)
      ..write(obj.imagepath)
      ..writeByte(4)
      ..write(obj.check)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.workout);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
