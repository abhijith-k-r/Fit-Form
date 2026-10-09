// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/diet_planner.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddHealtyDiets extends StatefulWidget {
  final DateTime? initialDate;

  const AddHealtyDiets({super.key, this.initialDate});

  @override
  State<AddHealtyDiets> createState() => _AddHealtyDietsState();
}

class _AddHealtyDietsState extends State<AddHealtyDiets> {
  final TextEditingController healthNamController = TextEditingController();
  final TextEditingController healthCaloriesController = TextEditingController();
  final TextEditingController healthDescriptionController = TextEditingController();

  String? selectedDietImage;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> pickingDietImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);

      if (pickedFile != null) {
        setState(() {
          selectedDietImage = pickedFile.path;
        });
      }
    } catch (_) {}
  }

  // Future<void> _pickCustomDate() async {
  //   final picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime.now().subtract(const Duration(days: 365)),
  //     lastDate: DateTime.now().add(const Duration(days: 365)),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  String _getDateLabel() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));
    final current = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    if (current == today) return 'Today';
    if (current == tomorrow) return 'Tomorrow';
    if (current == yesterday) return 'Yesterday';
    return '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
  }

  @override
  void dispose() {
    healthNamController.dispose();
    healthCaloriesController.dispose();
    healthDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = isDark.value;

    return Scaffold(
      backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: isDarkMode ? appcolorwhite : appcolorblack),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Healthy Diet',
          style: GoogleFonts.jost(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? appcolorwhite : appcolorblack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Day Selection Segment
              Text(
                'Plan for: ${_getDateLabel()}',
                style: GoogleFonts.jost(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? appcolorwhite : appcolorblack,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDayChip('Tomorrow', DateTime.now().add(const Duration(days: 1))),
                    const SizedBox(width: 8),
                    _buildDayChip('Today', DateTime.now()),
                    const SizedBox(width: 8),
                    // _buildDayChip('Yesterday', DateTime.now().subtract(const Duration(days: 1))),
                    // const SizedBox(width: 8),
                    // ActionChip(
                    //   avatar: const Icon(Icons.calendar_month, size: 16),
                    //   label: const Text('Pick Date'),
                    //   onPressed: _pickCustomDate,
                    //   backgroundColor: isDarkMode
                    //       ? const Color.fromARGB(255, 40, 40, 40)
                    //       : Colors.grey[200],
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Image upload card
              GestureDetector(
                onTap: pickingDietImage,
                child: Container(
                  width: double.infinity,
                  height: screenWidth * 0.45,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromARGB(255, 30, 30, 30)
                        : Colors.grey[100],
                    border: Border.all(
                      color: isDarkMode ? Colors.white24 : Colors.black12,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: (selectedDietImage != null &&
                          File(selectedDietImage!).existsSync())
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            File(selectedDietImage!),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 48,
                              color: appcolorRed,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Click to upload meal photo',
                              style: GoogleFonts.jost(
                                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),

              customTextfield(
                'Food Name',
                healthNamController,
                const Icon(Icons.restaurant_outlined),
              ),
              const SizedBox(height: 14),
              customTextfield(
                'Calories (kcal)',
                healthCaloriesController,
                const Icon(Icons.local_fire_department_outlined),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: healthDescriptionController,
                  maxLines: 3,
                  style: GoogleFonts.jost(
                    color: isDarkMode ? appcolorwhite : appcolorblack,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Description & ingredients...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 26),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textButton(
                    () => Navigator.pop(context),
                    'CANCEL',
                    EdgeInsets.zero,
                    appcolorRed,
                  ),
                  const SizedBox(width: 40),
                  textButton(
                    () {
                      if (healthNamController.text.trim().isEmpty) {
                        snackBarMessenger(
                            context, 'Please enter a food name', appcolorRed);
                        return;
                      }

                      final calories =
                          double.tryParse(healthCaloriesController.text) ?? 0.0;
                      final saveHealthyDiet = HealtyDiet(
                        healthname: healthNamController.text.trim(),
                        healthcalories: calories,
                        healthdescribe: healthDescriptionController.text.trim(),
                        healthimage: selectedDietImage,
                        dateTime: selectedDate,
                        favorite: false,
                      );

                      addHeathyDiets(saveHealthyDiet).then((_) {
                        getHealtyDiet();
                        Navigator.pop(context);
                      });
                    },
                    'ADD DIET',
                    EdgeInsets.zero,
                    appcolorgreen,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayChip(String label, DateTime targetDate) {
    final isSelected = selectedDate.year == targetDate.year &&
        selectedDate.month == targetDate.month &&
        selectedDate.day == targetDate.day;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: appcolorRed,
      labelStyle: GoogleFonts.jost(
        color: isSelected ? Colors.white : (isDark.value ? Colors.white : Colors.black),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            selectedDate = targetDate;
          });
        }
      },
    );
  }
}
