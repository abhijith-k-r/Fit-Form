// ignore_for_file: unused_element

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(
      text,
      style: GoogleFonts.jost(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget buildNumberInput(
  String label,
  IconData icon,
  String placeholder,
  TextEditingController controller,
) {
  return SizedBox(
    width: 150,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(label),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 2,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: Icon(icon, color: appcolorgrey.shade400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(5),
          ),
        ),
      ],
    ),
  );
}

Widget buildUploadPrompt() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.video_library,
        size: 40,
        color: appcolorgrey.shade500,
      ),
      const SizedBox(height: 8),
      Text(
        'Click to upload video',
        style: TextStyle(
          color: appcolorgrey.shade500,
          fontSize: 14,
        ),
      ),
    ],
  );
}

// ! Dyanmic_viewButton

Row dymaicViewofSteps(Function addStep) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton.icon(
        icon: Icon(
          Icons.add,
          color: appcolorRed,
        ),
        label: Text('Add Step',
            style: GoogleFonts.joan(
                fontSize: 15, fontWeight: FontWeight.w600, color: appcolorRed)),
        onPressed: () => addStep(),
      ),
    ],
  );
}

// ! Cancel Button For Add Workout><><><>

Expanded cancelButtonForAddScreen(BuildContext context) {
  return Expanded(
    child: textButton(() => Navigator.pop(context), 'Cancel',
        EdgeInsets.symmetric(vertical: 10), appcolorblue),
  );
}

// ! AddingButtonForAddScreen
Expanded addingButtonForAddScreen(
    BuildContext context,
    TextEditingController workoutNameController,
    TextEditingController durationController,
    Function saveWorkout) {
  return Expanded(
    child: textButton(() {
      if (workoutNameController.text.isEmpty ||
          durationController.text.isEmpty) {
        snackBarMessenger(context, 'Please fill all fields', appcolorRed);

        return;
      }
      saveWorkout();
    }, 'Save Exercise', EdgeInsets.symmetric(vertical: 10), appcolorgreen),
  );
}

// ! Wraped Contents For Sets||Reps||Dutation
Wrap workoutAddingWrapedContents(
    TextEditingController workoutSetsController,
    TextEditingController repeatController,
    TextEditingController durationController) {
  return Wrap(
    spacing: 40,
    runSpacing: 20,
    children: [
      buildNumberInput(
          'Sets', Icons.fitness_center, '3', workoutSetsController),
      buildNumberInput(
        'Reps',
        Icons.repeat,
        '12',
        repeatController,
      ),
      buildNumberInput(
          'Duration (minutes)', Icons.timer, '5', durationController),
    ],
  );
}

// ! Showing Screen WorkoutInfo<<><><><>
Widget workoutInfo(BuildContext context, IconData icon, String text) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Container(
    margin: const EdgeInsets.only(right: 12),
    child: Row(
      children: [
        Icon(icon, size: screenWidth * 0.05, color: appcolorRed),
        Text(
          text,
          style: GoogleFonts.jost(fontSize: screenWidth * 0.05),
        ),
      ],
    ),
  );
}

// !Showing Screen WorkoutSeectiosn<<><><><><
Widget workoutsection(BuildContext context, IconData icon, String title) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Row(
    spacing: 10,
    children: [
      Icon(
        icon,
        color: appcolorRed,
        size: screenWidth * 0.06,
      ),
      Text(
        title,
        style: GoogleFonts.jost(
            fontSize: screenWidth * 0.06, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
