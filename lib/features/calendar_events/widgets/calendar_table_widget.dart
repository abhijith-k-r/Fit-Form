import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/calendar_functions.dart';
import 'package:fit_form/functions/calendar_events.dart';
import 'package:fit_form/models/events_modal.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTableWidget extends StatelessWidget {
  const CalendarTableWidget({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    required this.titleController,
    required this.contentController,
  });

  final DateTime? selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime selected, DateTime focused) onDaySelected;
  final Function(CalendarFormat format) onFormatChanged;
  final Function(DateTime focused) onPageChanged;
  final TextEditingController titleController;
  final TextEditingController contentController;

  DateTime _strip(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(focusedDay.toString().split(" ")[0]),
        ValueListenableBuilder<List<Events>>(
          valueListenable: eventsNotifier,
          builder: (context, events, child) {
            return TableCalendar(
              selectedDayPredicate: (day) => isSameDay(day, selectedDay),
              focusedDay: focusedDay,
              availableGestures: AvailableGestures.all,
              firstDay: DateTime.utc(2004, 5, 3),
              lastDay: DateTime.utc(2070, 5, 3),
              onDaySelected: onDaySelected,
              calendarFormat: calendarFormat,
              onFormatChanged: onFormatChanged,
              onPageChanged: onPageChanged,
              calendarBuilders: _buildCalendarBuilders(),
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: appcolorRed,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: appcolorRed),
              ),
            );
          },
        ),
        CalendarExpandedSpace(focusedDay, titleController, contentController),
      ],
    );
  }

  CalendarBuilders<dynamic> _buildCalendarBuilders() {
    return CalendarBuilders(
      dowBuilder: (context, day) {
        if (day.weekday == DateTime.sunday) {
          return Center(
            child: Text(
              'Sun',
              style: TextStyle(color: appcolorRed, fontWeight: FontWeight.bold),
            ),
          );
        }
        return null;
      },
      selectedBuilder: (context, date, _) {
        return Container(
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(color: appcolorRed, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text('${date.day}', style: TextStyle(color: appcolorwhite)),
        );
      },
      todayBuilder: (context, date, _) {
        return Container(
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(color: appcolorRed, width: 2.0),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text('${date.day}', style: TextStyle(color: appcolorRed)),
        );
      },
      markerBuilder: (context, date, events) {
        if (eventsNotifier.value.any((e) =>
            e.date != null && _strip(e.date!) == _strip(date))) {
          return Positioned(
            bottom: 1,
            child: Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(color: appcolorRed, shape: BoxShape.circle),
            ),
          );
        }
        return null;
      },
    );
  }
}
