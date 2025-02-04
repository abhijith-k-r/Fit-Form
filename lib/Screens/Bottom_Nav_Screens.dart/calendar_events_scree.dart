import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/calendar_functions.dart';
import 'package:fit_form/functions/calendar_events.dart';
import 'package:fit_form/models/events_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEvents extends StatefulWidget {
  const CalendarEvents({super.key});

  @override
  State<CalendarEvents> createState() => _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  DateTime FocusedDAy = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? SelectedDAy;
  String? selectedImagepath;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    SelectedDAy = FocusedDAy;
    calendarInitialize();
    fetchEventsForDay(SelectedDAy!);
    super.initState();
  }

  void clearForm() {
    titleController.clear();
    contentController.clear();
    setState(() {
      selectedImagepath = null;
    });
  }

  DateTime stripTime(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calendar',
            style: GoogleFonts.fredoka(fontSize: 30),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            clearForm();
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isScrollControlled: true,
                builder: (context) => DraggableScrollableSheet(
                        builder: (BuildContext context, scrollController) {
                      final screenWidth = MediaQuery.of(context).size.width;

                      return StatefulBuilder(
                        builder: (context, setState) => Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: CustomScrollView(
                                controller: scrollController,
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).hintColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        height: 4,
                                        width: screenWidth * 0.1,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                      ),
                                    ),
                                  ),
                                  SliverAppBar(
                                    title: Text(
                                      'Add Your Goals',
                                      style: GoogleFonts.josefinSans(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    primary: false,
                                    pinned: true,
                                    centerTitle: false,
                                  ),
                                  SliverList.list(children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        child: Column(
                                            spacing: 20,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 0),
                                                child: TextField(
                                                  controller: titleController,
                                                  decoration: const InputDecoration(
                                                      hintText: 'Enter Title',
                                                      border:
                                                          OutlineInputBorder()),
                                                ),
                                              ),
                                             
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 0),
                                                child: TextField(
                                                  controller: contentController,
                                                  decoration: InputDecoration(
                                                      prefix: Icon(Icons.edit),
                                                      hintText:
                                                          'Enter Description',
                                                      border:
                                                          OutlineInputBorder()),
                                                  maxLines: 5,
                                                ),
                                              ),
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        appcolorblack,
                                                    minimumSize: Size(240, 40),
                                                    side: BorderSide(
                                                        color: appcolorRed,
                                                        width: 1),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                  ),
                                                  onPressed: () async {
                                                    if (titleController
                                                            .text.isEmpty ||
                                                        contentController
                                                            .text.isEmpty) {
                                                      return;
                                                    }
                                                    final newEvent = Events(
                                                        title: titleController
                                                            .text,
                                                        contents:
                                                            contentController
                                                                .text,
                                                        date: SelectedDAy);
                                                    await addEvents(
                                                        SelectedDAy!, newEvent);

                                                    await fetchEventsForDay(
                                                        SelectedDAy!);
                                                    clearForm();
                                                    setState(() {});
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Add Goals',
                                                    style: GoogleFonts.inter(
                                                        color: appcolorwhite,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                            ]))
                                  ])
                                ])),
                      );
                    }));
          },
          backgroundColor: appcolorRed,
          child: Icon(
            Icons.edit,
            color: appcolorwhite,
          ),
        ),
        body: Calendar());
  }

  Column Calendar() {
    return Column(
      children: [
        Text(FocusedDAy.toString().split(" ")[0]),
        ValueListenableBuilder<List<Events>>(
          valueListenable: eventsNotifier,
          builder: (context, events, child) {
            return TableCalendar(
              selectedDayPredicate: (day) => isSameDay(day, SelectedDAy),
              focusedDay: FocusedDAy,
              availableGestures: AvailableGestures.all,
              firstDay: DateTime.utc(2004, 5, 3),
              lastDay: DateTime.utc(2070, 5, 3),
              onDaySelected: (newSelectedDay, newFocusedDay) {
                setState(() {
                  SelectedDAy = newSelectedDay;
                  FocusedDAy = newFocusedDay;
                });
                fetchEventsForDay(newSelectedDay);
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (newfocusDay) {
                setState(() {
                  FocusedDAy = newfocusDay;
                });
              },
              calendarBuilders: CalendarBuilder(),
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
        CalendarExpandedSpace(FocusedDAy, titleController, contentController),
      ],
    );
  }

  CalendarBuilders<dynamic> CalendarBuilder() {
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
          decoration: BoxDecoration(
            color: appcolorRed,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '${date.day}',
            style: TextStyle(color: appcolorwhite),
          ),
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
          child: Text(
            '${date.day}',
            style: TextStyle(color: appcolorRed),
          ),
        );
      },
      markerBuilder: (context, date, events) {
        if (eventsNotifier.value.any((event) =>
            event.date != null && stripTime(event.date!) == stripTime(date))) {
          return Positioned(
            bottom: 1,
            child: Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                color: appcolorRed,
                shape: BoxShape.circle,
              ),
            ),
          );
        }
        return null;
      },
    );
  }
}

Future<String?> pickingImage() async {
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Create a permanent copy of the image in app directory
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = File('${appDir.path}/$fileName');

      await File(pickedFile.path).copy(savedImage.path);
      return savedImage.path;
    }
    return null;
  } catch (e) {
    return null;
  }
}
