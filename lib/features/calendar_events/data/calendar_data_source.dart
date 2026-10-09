// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fit_form/core/constants/app_keys.dart';
import 'package:fit_form/models/events_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Reactive notifier for the events visible on the selected calendar day.
final ValueNotifier<List<Events>> eventsNotifier =
    ValueNotifier<List<Events>>([]);

/// Hive CRUD for [Events] — all date-key logic isolated here.
class CalendarDataSource {
  CalendarDataSource._();

  static Future<Box<Map>> _box() =>
      Hive.openBox<Map>(AppKeys.eventBox);

  static String _dayKey(DateTime date) =>
      date.toString().split(' ').first;

  static Future<void> initialize() async {
    if (!Hive.isAdapterRegistered(EventsAdapter().typeId)) {
      Hive.registerAdapter(EventsAdapter());
    }
  }

  static Future<void> loadForDay(DateTime date) async {
    final box = await _box();
    final Object? rawData = box.get(_dayKey(date));
    final Map<dynamic, dynamic> dayEvents;

    if (rawData is List) {
      final List listData = rawData;
      dayEvents = {
        for (int i = 0; i < listData.length; i++) i.toString(): listData[i]
      };
      await box.put(_dayKey(date), dayEvents);
    } else if (rawData is Map) {
      dayEvents = rawData;
    } else {
      dayEvents = {};
    }

    eventsNotifier.value = dayEvents.values
        .map((e) => Events.fromMap(e as Map<dynamic, dynamic>))
        .toList();
    eventsNotifier.notifyListeners();
  }

  static Future<void> add(DateTime date, Events event) async {
    final box = await _box();
    final key = _dayKey(date);
    final Map<dynamic, dynamic> dayEvents =
        box.get(key) ?? {};
    event.id = DateTime.now().millisecondsSinceEpoch.toString();
    dayEvents[event.id!] = event.toMap();
    await box.put(key, dayEvents);
    await loadForDay(date);
  }

  static Future<void> delete(DateTime date, String eventId) async {
    final box = await _box();
    final key = _dayKey(date);
    final Map<dynamic, dynamic> dayEvents =
        box.get(key, defaultValue: {})!;
    if (dayEvents.containsKey(eventId)) {
      dayEvents.remove(eventId);
      await box.put(key, dayEvents);
    }
    await loadForDay(date);
  }

  static Future<void> update(
      DateTime date, String eventId, Events updated) async {
    final box = await _box();
    final key = _dayKey(date);
    final Map<dynamic, dynamic> dayEvents =
        box.get(key, defaultValue: {})!;
    if (dayEvents.containsKey(eventId)) {
      updated.id = eventId;
      dayEvents[eventId] = updated.toMap();
      await box.put(key, dayEvents);
    }
    await loadForDay(date);
  }
}
