import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/diet_funtions.dart';
import 'package:fit_form/models/diet_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalorieFoodListSection extends StatelessWidget {
  const CalorieFoodListSection({
    super.key,
    required this.totalCalories,
    required this.onRemoveItem,
  });

  final double totalCalories;
  final VoidCallback onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: appcolorRed.withValues(alpha: 0.1),
            ),
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                title: Text('Total Calories: ${totalCalories.toStringAsFixed(2)}'),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
          child: ValueListenableBuilder<List<FoodItems>>(
            valueListenable: foodItemNotify,
            builder: (context, List<FoodItems> foods, _) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: appcolorRed.withValues(alpha: 0.1),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          onTap: () async {
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Are you Sure\n Remove this?', textAlign: TextAlign.center),
                                actions: [
                                  Center(
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(ctx, false),
                                          child: Text('Cancel', style: GoogleFonts.jost(fontWeight: FontWeight.bold, fontSize: 15)),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(ctx, true),
                                          child: Text('Remove', style: GoogleFonts.jost(color: appcolorRed, fontWeight: FontWeight.bold, fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                            if (shouldDelete == true) {
                              await removeCalorie(index, onRemoveItem);
                            }
                          },
                          title: Text(food.foodName, style: GoogleFonts.jost(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            'Quantity: ${food.gram}g | Calories: ${food.calories.toStringAsFixed(2)} kcal\n'
                            'P: ${food.protien.toStringAsFixed(1)}g | F: ${food.fat.toStringAsFixed(1)}g | C: ${food.carbohydrates.toStringAsFixed(1)}g',
                            style: GoogleFonts.jost(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
