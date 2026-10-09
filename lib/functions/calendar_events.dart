library;

// Legacy compatibility shim.
/// Calendar logic has moved to:
///   lib/features/calendar_events/data/calendar_data_source.dart

export 'package:fit_form/features/calendar_events/data/calendar_data_source.dart'
    show CalendarDataSource, eventsNotifier;

import 'package:fit_form/features/calendar_events/data/calendar_data_source.dart';
import 'package:fit_form/models/events_modal.dart';

/// Old notifier name kept for existing screen compatibility.
final eventsNotifier2 = eventsNotifier; // eventsNotifier already exported above

Future<void> calendarInitialize() => CalendarDataSource.initialize();
Future<void> addEvents(DateTime date, Events event) =>
    CalendarDataSource.add(date, event);
Future<void> getEventsForDay(DateTime date) =>
    CalendarDataSource.loadForDay(date);
Future<void> fetchEventsForDay(DateTime day) =>
    CalendarDataSource.loadForDay(day);
Future<void> deleteEvent(DateTime date, String eventId) =>
    CalendarDataSource.delete(date, eventId);
Future<void> editEvent(DateTime date, String eventId, Events updated) =>
    CalendarDataSource.update(date, eventId, updated);
