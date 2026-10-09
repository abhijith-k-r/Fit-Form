import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/diet_funtions.dart';
import 'package:fit_form/models/diet_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalorieInputForm extends StatelessWidget {
  const CalorieInputForm({
    super.key,
    required this.selectedFood,
    required this.gramsController,
    required this.onFoodChanged,
    required this.onAddFood,
  });

  final String? selectedFood;
  final TextEditingController gramsController;
  final ValueChanged<String?> onFoodChanged;
  final VoidCallback onAddFood;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: DropdownButtonFormField<String>(
            initialValue: selectedFood,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            ),
            items: foodItems.map((FoodItems item) {
              return DropdownMenuItem<String>(
                value: item.foodName,
                alignment: AlignmentDirectional.center,
                child: Text(item.foodName),
              );
            }).toList(),
            onChanged: onFoodChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
          child: TextFormField(
            controller: gramsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter grams (1-2000)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: TextButton(
            onPressed: onAddFood,
            child: Text(
              'CALORIES',
              style: GoogleFonts.joan(
                color: appcolorRed,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
