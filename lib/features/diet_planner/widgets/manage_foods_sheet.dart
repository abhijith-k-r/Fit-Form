import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/diet_planner/data/diet_data_source.dart';
import 'package:fit_form/features/diet_planner/widgets/add_food_dialog.dart';
import 'package:fit_form/models/diet_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modal bottom sheet allowing users to view and delete foods from their catalogue.
class ManageFoodsSheet extends StatelessWidget {
  const ManageFoodsSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ManageFoodsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Food Items',
                    style: GoogleFonts.jost(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => AddFoodDialog.show(context),
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(
                      'Add Food',
                      style: GoogleFonts.jost(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ValueListenableBuilder<List<FoodItems>>(
                  valueListenable: foodCatalogueNotifier,
                  builder: (context, items, _) {
                    if (items.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.restaurant_menu, size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 8),
                            Text(
                              'No foods in your list yet',
                              style: GoogleFonts.jost(fontSize: 16, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      controller: scrollController,
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          title: Text(
                            item.foodName,
                            style: GoogleFonts.jost(fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          subtitle: Text(
                            'Per 100g: ${item.calories.toStringAsFixed(0)} kcal | '
                            'P: ${item.protien.toStringAsFixed(1)}g | '
                            'F: ${item.fat.toStringAsFixed(1)}g | '
                            'C: ${item.carbohydrates.toStringAsFixed(1)}g',
                            style: GoogleFonts.jost(fontSize: 12, color: Colors.grey.shade600),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            tooltip: 'Delete Food',
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Delete Food Item?'),
                                  content: Text('Remove "${item.foodName}" from your food list?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx, true),
                                      child: Text('Delete', style: TextStyle(color: appcolorRed)),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                await DietDataSource.removeCatalogueItem(index);
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
