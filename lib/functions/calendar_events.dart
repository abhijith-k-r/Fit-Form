import 'package:fit_form/models/events_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final eventsNotifier = ValueNotifier<List<Events>>([]);

Future<void> calendarInitialize() async {
  if (!Hive.isAdapterRegistered(EventsAdapter().typeId)) {
    Hive.registerAdapter(EventsAdapter());
  }
}

Future<void> addEvents(DateTime date, Events event) async {
  final db = await Hive.openBox<Map>('EventBox');
  final dayKey = date.toString().split(' ')[0]; 

 // ignore: unnecessary_cast
 Map<dynamic, dynamic> dayEvents = (db.get(dayKey) ?? {}) as Map<dynamic, dynamic>;
  String customId = DateTime.now().millisecondsSinceEpoch.toString();
  event.id = customId;
  dayEvents[customId] = event.toMap();

  await db.put(dayKey, dayEvents);
}



Future<void> getEventsForDay(DateTime date) async {
  final db = await Hive.openBox<Map>('EventBox');
  final dayKey = date.toString().split(' ')[0]; 

  final rawData = db.get(dayKey);
  Map<dynamic, dynamic> dayEvents;

  if (rawData is List) {
    dayEvents = {for (var i = 0; i < rawData!.length; i++) i.toString(): rawData[i]};
    await db.put(dayKey, dayEvents); 
  } else if (rawData is Map) {
    dayEvents = rawData;
  } else {
    dayEvents = {};
  }

  final events = dayEvents.values.map((e) => Events.fromMap(e)).toList();
  eventsNotifier.value = events;
}


Future<void> deleteEvent(DateTime date, String eventId) async {

  final db = await Hive.openBox<Map>('EventBox');
  final dayKey = date.toString().split(' ')[0]; 
  Map<dynamic, dynamic> dayEvents = db.get(dayKey, defaultValue: {})!;
  
  if (dayEvents.containsKey(eventId)) {
    dayEvents.remove(eventId);
    await db.put(dayKey, dayEvents);
  }
}


Future<void> editEvent(DateTime date, String eventId, Events updatedEvent) async {
  final db = await Hive.openBox<Map>('EventBox');
  final dayKey = date.toString().split(' ')[0];
  Map<dynamic, dynamic> dayEvents = db.get(dayKey, defaultValue: {})!;
  
  if (dayEvents.containsKey(eventId)) {
    updatedEvent.id = eventId; // Retain the original ID
    dayEvents[eventId] = updatedEvent.toMap();
    await db.put(dayKey, dayEvents);
  }
}

  Future<void> fetchEventsForDay(DateTime day) async {
    await getEventsForDay(day);
  }



  // ValueNotifier<List<Events>> eventsDatas = ValueNotifier([]);

// Future<void> getEents() async {
//   final db = await Hive.openBox<Events>('EventBox');
//   eventsDatas.value.clear();
//   eventsDatas.value.addAll(db.values);
//   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//   eventsDatas.notifyListeners();
// }



// Future<void> addEvents(DateTime date, Events event) async {
//   final db = await Hive.openBox<Events>('EventBox');
//   String customId = DateTime.now().millisecondsSinceEpoch.toString();
//   event.id = customId;
//   // events.addAll()
//   await db.put(event.id, event);
// }

// Future<void> getEventsForDay(DateTime date) async {
//   final db = await Hive.openBox<Events>('EventBox');
//   final events = db.values.where((event) {
//     final eventDate = DateTime.fromMillisecondsSinceEpoch(int.parse(event.id!));
//     return isSameDay(date, eventDate);
//   }).toList();
//   eventsNotifier.value = events;
// }