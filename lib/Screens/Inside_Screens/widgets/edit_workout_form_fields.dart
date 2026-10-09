import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:flutter/material.dart';

class EditWorkoutFormFields extends StatelessWidget {
  const EditWorkoutFormFields({
    super.key,
    required this.nameController,
    required this.benefitsController,
    required this.stepsController,
    required this.setsController,
    required this.repeatsController,
    required this.durationController,
    required this.difficulty,
    required this.onDifficultyChanged,
  });

  final TextEditingController nameController;
  final TextEditingController benefitsController;
  final TextEditingController stepsController;
  final TextEditingController setsController;
  final TextEditingController repeatsController;
  final TextEditingController durationController;
  final String? difficulty;
  final ValueChanged<String?> onDifficultyChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel('Exercise Name'),
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'e.g., Push-ups, Squats',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 20),
        buildLabel('Benefits'),
        TextFormField(
          controller: benefitsController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'List the benefits of this exercise...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 20),
        buildLabel('How to Do'),
        TextFormField(
          controller: stepsController,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: 'Step by step instructions...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 20),
        workoutAddingWrapedContents(setsController, repeatsController, durationController),
        const SizedBox(height: 20),
        buildLabel('Difficulty Level'),
        DropdownButtonFormField<String>(
          initialValue: difficulty,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(16),
          ),
          items: ['Beginner', 'Intermediate', 'Advanced']
              .map((value) => DropdownMenuItem<String>(
                    value: value,
                    alignment: AlignmentDirectional.center,
                    child: Text(value),
                  ))
              .toList(),
          onChanged: onDifficultyChanged,
        ),
      ],
    );
  }
}
