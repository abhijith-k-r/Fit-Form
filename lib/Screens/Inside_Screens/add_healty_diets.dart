// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/diet_planner.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddHealtyDiets extends StatelessWidget {
  AddHealtyDiets({super.key});

  TextEditingController healthNamController = TextEditingController();
  TextEditingController healthCaloriesController = TextEditingController();
  TextEditingController healthDescriptionController = TextEditingController();

  String? selectedDietImage;

  Future<void> pickingDietImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedDietImage = pickedFile.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            SizedBox(
              height: screewidth * 0.4,
            ),
            customTextfield('Food Name', healthNamController,
                Icon(Icons.food_bank_outlined)),
            GestureDetector(
              onTap: pickingDietImage,
              child: Container(
                width: screewidth * 0.8,
                height: screewidth * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: appcolorgrey,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: selectedDietImage != null
                    ? Image.file(
                        File(selectedDietImage!),
                        fit: BoxFit.cover,
                      )
                    : Column(
                        spacing: screewidth * 0.04,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: screewidth * 0.1,
                          ),
                          Text(
                            'Click to upload ',
                            style: TextStyle(
                              color: appcolorgrey,
                              fontSize: screewidth * 0.04,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            customTextfield("Calories", healthCaloriesController,
                Icon(Icons.food_bank_outlined)),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextFormField(
                controller: healthDescriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                textButton(() => Navigator.pop(context), 'CANCEL',
                    EdgeInsets.zero, appcolorRed),
                textButton(() {
                  double calories =
                      double.tryParse(healthCaloriesController.text) ?? 0.0;
                  final saveHealthyDiet = HealtyDiet(
                    
                      healthname: healthNamController.text,
                      healthcalories: calories,
                      healthdescribe: healthDescriptionController.text,
                      healthimage: selectedDietImage);
                  addHeathyDiets(saveHealthyDiet).then((_) {
                    getHealtyDiet();
                    healthyNotify.notifyListeners();
                    Navigator.pop(context);
                  });
                }, 'ADD DIET', EdgeInsets.zero, appcolorgreen),
              ],
            )
          ],
        ),
      )),
    );
  }
}

