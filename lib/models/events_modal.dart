import 'package:hive_flutter/hive_flutter.dart';

part 'events_modal.g.dart';

@HiveType(typeId: 3)
class Events {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? contents;

  @HiveField(3)
  String? imagepath;

  @HiveField(4)
  bool? check = false;

  @HiveField(5)
  DateTime? date;

  @HiveField(6)
  Map<String, String> workout;

  Events(
      {this.id,
      this.title,
      this.contents,
      this.imagepath,
      this.check,
      this.date,
      Map<String, String>? workout})
      : workout = workout ?? {};

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'contents': contents,
      'image':imagepath,
      'check':check,
      'date': date?.toIso8601String(),
    };
  }

  factory Events.fromMap(Map<dynamic, dynamic> map) {
    return Events(
      id: map['id'],
      title: map['title'],
      contents: map['contents'],
      imagepath: map['imagepath'],
      check: map['check'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
    );
  }
}
