import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/calendar_events/widgets/add_goal_modal_sheet.dart';
import 'package:fit_form/features/calendar_events/widgets/calendar_table_widget.dart';
import 'package:fit_form/functions/calendar_events.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEvents extends StatefulWidget {
  const CalendarEvents({super.key});

  @override
  State<CalendarEvents> createState() => _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  DateTime focusedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime? selectedDay;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDay = focusedDay;
    calendarInitialize();
    fetchEventsForDay(selectedDay!);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _openAddGoalModal() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => AddGoalModalSheet(
        selectedDay: selectedDay,
        onGoalAdded: () => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, isDarkMode, _) {
        return Scaffold(
          backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
          appBar: AppBar(
            backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
            elevation: 0,
            title: Text('Calendar', style: GoogleFonts.fredoka(fontSize: 30)),
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: _openAddGoalModal,
            backgroundColor: appcolorRed,
            child: Icon(Icons.edit, color: appcolorwhite),
          ),
          body: CalendarTableWidget(
            selectedDay: selectedDay,
            focusedDay: focusedDay,
            calendarFormat: calendarFormat,
            titleController: titleController,
            contentController: contentController,
            onDaySelected: (newSelected, newFocused) {
              setState(() {
                selectedDay = newSelected;
                focusedDay = newFocused;
              });
              fetchEventsForDay(newSelected);
            },
            onFormatChanged: (format) {
              if (calendarFormat != format) {
                setState(() => calendarFormat = format);
              }
            },
            onPageChanged: (newFocus) => setState(() => focusedDay = newFocus),
          ),
        );
      },
    );
  }
}
