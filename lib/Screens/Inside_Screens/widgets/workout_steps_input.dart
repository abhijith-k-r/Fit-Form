import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:flutter/material.dart';

class WorkoutStepsInput extends StatelessWidget {
  const WorkoutStepsInput({
    super.key,
    required this.stepControllers,
    required this.onAddStep,
    required this.onRemoveStep,
  });

  final List<TextEditingController> stepControllers;
  final VoidCallback onAddStep;
  final ValueChanged<int> onRemoveStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel('How to Do'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stepControllers.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: TextFormField(
                      controller: stepControllers[index],
                      decoration: InputDecoration(
                        hintText: 'Step ${index + 1}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => onRemoveStep(index),
                ),
              ],
            );
          },
        ),
        dymaicViewofSteps(onAddStep),
      ],
    );
  }
}
