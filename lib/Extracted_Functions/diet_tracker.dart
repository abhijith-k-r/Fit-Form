// ! Show Snack Bar

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_category_instruction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void snackBarMessenger(BuildContext context, String text, Color colors) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: colors,
      content: Text(
        text,
        style: GoogleFonts.jost(),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

// ! BMI_TEXTFIELD_>>><><<<

Padding bmiTextfield(
    TextEditingController Controller, String label, Widget icons) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
    child: TextField(
      controller: Controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        icon: icons,
      ),
    ),
  );
}

// ! TextButton For Some Screens
Padding textButton(
    Function() addSelectedFood, String text, EdgeInsets padding, Color color) {
  return Padding(
    padding: padding,
    child: TextButton(
        onPressed: addSelectedFood,
        child: Text(text,
            style: GoogleFonts.joan(
                color: color, fontWeight: FontWeight.bold, fontSize: 17))),
  );
}

// !Diet_Recommendations_Under_the_Result
Widget getDietRecommendation(String bmiCategory) {
  switch (bmiCategory) {
    case 'UnderWeight':
      return Text(
        'Recommendation: High-calorie, nutrient-dense diet with increased protein and healthy fats.',
        textAlign: TextAlign.center,
        style: GoogleFonts.jost(),
      );
    case 'Normal':
      return Text(
        'Recommendation: Balanced diet with moderate portions of proteins, carbs, and healthy fats.',
        textAlign: TextAlign.center,
        style: GoogleFonts.jost(),
      );
    case 'OverWeight':
      return Text(
        'Recommendation: Calorie-controlled diet with emphasis on whole foods, lean proteins, and reduced carbohydrates.',
        textAlign: TextAlign.center,
        style: GoogleFonts.jost(),
      );
    case 'Obese':
      return Text(
        'Recommendation: Calorie-restricted diet with high protein, low carbs, and regular exercise.',
        textAlign: TextAlign.center,
        style: GoogleFonts.jost(),
      );
    default:
      return Text(
        'Calculate your BMI for personalized diet recommendations.',
        textAlign: TextAlign.center,
        style: GoogleFonts.jost(),
      );
  }
}

// ! Another_Instructions_But_Predefined Under the Result
// ! Like a HorizontallyScrollable><><><><><><><><><><><>
Widget predefinedDietCategories(BuildContext context, String bmicategoryItems) {
  List<dynamic> selectedplan = [];

  switch (bmicategoryItems) {
    case 'UnderWeight':
      selectedplan = predefinedPlansone;
      break;
    case 'Normal':
      selectedplan = predefinedplantwo;
      break;
    case 'OverWeight':
    case 'Obese':
      selectedplan = predefinedplanthree;
      break;
    default:
      return Center(
          child: Text('No diet categories available for this category.',
              style:
                  GoogleFonts.jost(fontSize: 16, fontWeight: FontWeight.bold)));
  }
  final screenWidth = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Diet Categories',
          style: GoogleFonts.jost(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: selectedplan.map((plan) {
            return Container(
              width: screenWidth * 0.7,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: appcolorgrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: GoogleFonts.jost(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    plan.items,
                    style: GoogleFonts.jost(fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

List<DietPlanUnderWeight> predefinedPlansone = [
  DietPlanUnderWeight(
      name: 'Protein',
      items:
          'Eat lean meats, fish, eggs, dairy, and vegetarian options like nuts, seeds, and soyproducts.'),
  DietPlanUnderWeight(
      name: 'Carbohydrates ',
      items:
          'Eat whole grains and high-fiber snacks like peanut butter cracker, trail mix, and pita chips.'),
  DietPlanUnderWeight(name: 'Meals', items: 'Eat several small meals a day.')
];

List<DietPlanNormalWeight> predefinedplantwo = [
  DietPlanNormalWeight(
      name: 'Fruits and Vegetables',
      items: 'Eat at least five portions of fruits and vegetables per day.'),
  DietPlanNormalWeight(
      name: 'Grains',
      items: 'Eat whole grains like brown rice,  quinoa, and whole wheat.'),
  DietPlanNormalWeight(
      name: 'Protein',
      items:
          'Eat lean meats, fish, eggs, beans, and dairy or dairy alternatives.'),
  DietPlanNormalWeight(
      name: 'Fiber',
      items:
          'Eat foods with high fiber content, like potaotes, brad, rice, or pasta.')
];
List<DietPlanOverObese> predefinedplanthree = [
  DietPlanOverObese(
      name: 'Fruits and Vegetables',
      items: 'Eat plenty of fruits and vegetables.'),
  DietPlanOverObese(
      name: 'Starchy foods',
      items:
          'Eat meals based on starch foods like potaoes, brad, rice, and pasta.'),
  DietPlanOverObese(
      name: 'Protein',
      items:
          'Eat some meat, fish, eggs, beans, and other non-dairy sources of protein.'),
  DietPlanOverObese(
      name: 'Dairy',
      items: 'Eat some milk and dairy foods or dairy alternatives.')
];
