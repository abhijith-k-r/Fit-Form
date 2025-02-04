import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/calendar_events.dart';
import 'package:fit_form/models/events_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//! Calendar_Edit_Fuction >< <> ><

EditFuction(
  BuildContext context,
  String eventId,
  TextEditingController titleController,
  TextEditingController contentController,
  DateTime SelectedDAy,
  String? initialImagePath,
) async {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
            builder: (BuildContext context, scrollController) {
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                            height: 4,
                            width: 50,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      SliverAppBar(
                        title: Text(
                          'Edit Your Goals',
                          style: GoogleFonts.josefinSans(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        primary: false,
                        pinned: true,
                        centerTitle: false,
                      ),
                      SliverList.list(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 30),
                              TextField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                    hintText: 'Edit Title',
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: contentController,
                                decoration: const InputDecoration(
                                    hintText: 'Edit Description',
                                    border: OutlineInputBorder()),
                                maxLines: 5,
                              ),
                              const SizedBox(height: 20),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: appcolorblack,
                                  minimumSize: const Size(240, 40),
                                  side:
                                      BorderSide(color: appcolorRed, width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () async {
                                  final updatedEvent = Events(
                                    id: eventId,
                                    title: titleController.text,
                                    contents: contentController.text,
                                  );
                                  await editEvent(
                                      SelectedDAy, eventId, updatedEvent);
                                  await fetchEventsForDay(SelectedDAy);

                                  if (context.mounted) Navigator.pop(context);
                                },
                                child: Text(
                                  'Update Goals',
                                  style: GoogleFonts.inter(
                                      color: appcolorwhite,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              );
            },
          ));
}

//! Expanded_Spaces >< <> ><

Expanded CalendarExpandedSpace(
  DateTime SelectedDAy,
  TextEditingController titleController,
  TextEditingController contentController,
) {
  return Expanded(
    child: ValueListenableBuilder<List<Events>>(
      valueListenable: eventsNotifier,
      builder: (context, events, child) {
        if (events.isEmpty) {
          return const Center(child: Text('No events for this day.'));
        }
        final screenWidth = MediaQuery.of(context).size.width;

        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return GestureDetector(
                onTap: () {
                  titleController.text = event.title ?? '';
                  contentController.text = event.contents ?? '';
                  EditFuction(context, event.id!, titleController,
                      contentController, SelectedDAy, event.imagepath);
                },
                onLongPress: () async {
                  DeleteFunction(context, event.id!, SelectedDAy);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              event.title!,
                              style: GoogleFonts.jost(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Checkbox(
                              activeColor: appcolorRed,
                              value: event.check ?? false,
                              onChanged: (bool? value) async {
                                event.check = value ?? false;
                                await editEvent(SelectedDAy, event.id!, event);
                                fetchEventsForDay(SelectedDAy);
                              },
                            ),
                          ),
                          Divider(indent: 20, endIndent: 20),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(
                              event.contents!,
                              style: GoogleFonts.jost(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    ),
  );
}

// !  Calendar_Delete_Pop-Up_Fuction

void DeleteFunction(
    BuildContext context, String eventId, DateTime SelectedDAy) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: AlertDialog(
        title: const Text(
          'Are you sure you want to delete this event?',
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    // Delete event logic
                    await deleteEvent(SelectedDAy, eventId);
                    await fetchEventsForDay(SelectedDAy);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Delete',
                    style: GoogleFonts.jost(
                      color: appcolorRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.jost(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
