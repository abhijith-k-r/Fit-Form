import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/calendar_events.dart';
import 'package:fit_form/models/events_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddGoalModalSheet extends StatefulWidget {
  const AddGoalModalSheet({
    super.key,
    required this.selectedDay,
    required this.onGoalAdded,
  });

  final DateTime? selectedDay;
  final VoidCallback onGoalAdded;

  @override
  State<AddGoalModalSheet> createState() => _AddGoalModalSheetState();
}

class _AddGoalModalSheetState extends State<AddGoalModalSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in both title and description.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    final newEvent = Events(
      title: titleController.text,
      contents: contentController.text,
      date: widget.selectedDay,
    );
    if (widget.selectedDay != null) {
      await addEvents(widget.selectedDay!, newEvent);
      await fetchEventsForDay(widget.selectedDay!);
      widget.onGoalAdded();
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('🎯 Event added successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Container(
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
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    height: 4,
                    width: screenWidth * 0.1,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              SliverAppBar(
                title: Text(
                  'Add Your Goals',
                  style: GoogleFonts.josefinSans(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                primary: false,
                pinned: true,
                centerTitle: false,
              ),
              SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23, 20, 23, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: contentController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.edit),
                            hintText: 'Enter Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: appcolorblack,
                            minimumSize: const Size(240, 44),
                            side: BorderSide(color: appcolorRed, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _submit,
                          child: Text(
                            'Add Goals',
                            style: GoogleFonts.inter(
                              color: appcolorwhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
