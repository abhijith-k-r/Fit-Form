// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/diet_planner.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HealthyEdit extends StatelessWidget {
  const HealthyEdit({super.key, required this.changDiets});
  final HealtyDiet changDiets;

  @override
  Widget build(BuildContext context) {
    final changName = TextEditingController(text: changDiets.healthname);
    final changCalories =
        TextEditingController(text: changDiets.healthcalories.toString());
    final changDescription =
        TextEditingController(text: changDiets.healthdescribe);
    final screenwidth = MediaQuery.of(context).size.width;
    String? changeImage = changDiets.healthimage;

    Future<void> pickedDietImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        changeImage = pickedFile.path;
        changDiets.healthimage = changeImage;
      }
    }

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          SizedBox(
            height: screenwidth * 0.4,
          ),
          customTextfield(
              'Food Name', changName, Icon(Icons.food_bank_outlined)),
          GestureDetector(
            onTap: pickedDietImage,
            child: Container(
              width: screenwidth * 0.8,
              height: screenwidth * 0.4,
              decoration: BoxDecoration(
                border: Border.all(
                  color: appcolorgrey,
                  style: BorderStyle.solid,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: (changeImage != null && File(changeImage!).existsSync())
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(changeImage!),
                        width: screenwidth * 0.8,
                        height: screenwidth * 0.8,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      spacing: screenwidth * 0.04,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: screenwidth * 0.1,
                        ),
                        Text(
                          'Click to upload ',
                          style: TextStyle(
                            color: appcolorgrey,
                            fontSize: screenwidth * 0.04,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          customTextfield(
              "Calories", changCalories, Icon(Icons.food_bank_outlined)),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: TextFormField(
              controller: changDescription,
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
              textButton(() async {
                double changeCalories =
                    double.tryParse(changCalories.text) ?? 0.0;
                final updatedDiet = HealtyDiet(
                    id: changDiets.id,
                    healthname: changName.text,
                    healthcalories: changeCalories,
                    healthdescribe: changDescription.text,
                    healthimage: changeImage,
                    dateTime: changDiets.dateTime ?? DateTime.now(),
                    favorite: changDiets.favorite);
                editHealthyDiet(changDiets.id!, updatedDiet);
                getHealtyDiet();
                healthyNotify.notifyListeners();
                Navigator.pop(context);
              }, 'EDITE DIETES', EdgeInsets.zero, appcolorgreen),
            ],
          )
        ],
      ),
    )));
  }
}
