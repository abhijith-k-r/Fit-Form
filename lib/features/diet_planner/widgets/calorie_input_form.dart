import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/diet_planner/data/diet_data_source.dart';
import 'package:fit_form/features/diet_planner/widgets/add_food_dialog.dart';
import 'package:fit_form/features/diet_planner/widgets/manage_foods_sheet.dart';
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
    return ValueListenableBuilder<List<FoodItems>>(
      valueListenable: foodCatalogueNotifier,
      builder: (context, catalogue, _) {
        final bool hasFood = catalogue.any((i) => i.foodName == selectedFood);
        final String? effectiveValue = hasFood ? selectedFood : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Row: Food Selector Title + Action buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 12, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose Food',
                    style: GoogleFonts.jost(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () async {
                          final addedName = await AddFoodDialog.show(context);
                          if (addedName != null) {
                            onFoodChanged(addedName);
                          }
                        },
                        icon: Icon(Icons.add_circle_outline, size: 16, color: appcolorRed),
                        label: Text(
                          'Add Food',
                          style: GoogleFonts.jost(
                            color: appcolorRed,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Manage saved foods',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.tune, size: 18),
                        onPressed: () => ManageFoodsSheet.show(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Dropdown / Empty State
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 6, 25, 0),
              child: catalogue.isEmpty
                  ? OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        final addedName = await AddFoodDialog.show(context);
                        if (addedName != null) {
                          onFoodChanged(addedName);
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: Text(
                        'No foods yet. Tap to add your first food!',
                        style: GoogleFonts.jost(fontSize: 14),
                      ),
                    )
                  : DropdownButtonFormField<String>(
                      key: ValueKey(catalogue.length),
                      initialValue: effectiveValue,
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: 'Select food from your list',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: catalogue.map((FoodItems item) {
                        return DropdownMenuItem<String>(
                          value: item.foodName,
                          child: Text(
                            '${item.foodName} (${item.calories.toStringAsFixed(0)} kcal/100g)',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.jost(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      onChanged: onFoodChanged,
                    ),
            ),

            // Grams Input
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 12, 25, 0),
              child: TextFormField(
                controller: gramsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter grams (1-2000)',
                  labelText: 'Portion (grams)',
                  suffixText: 'g',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            // Calculate Button
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 16, 25, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appcolorRed,
                  foregroundColor: appcolorwhite,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: onAddFood,
                child: Text(
                  'CALCULATE & ADD',
                  style: GoogleFonts.jost(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
