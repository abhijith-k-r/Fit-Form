import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/meal_tracking_section.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ! Calories_Calculator_Screen_Carosal <><>
CarouselSlider caloreCalculatorCarousel(
    BuildContext context, List<Map<String, dynamic>> carousalItems) {
  final screenWidth = MediaQuery.of(context).size.width;

  return CarouselSlider.builder(
      itemCount: carousalItems.length,
      itemBuilder: (context, index, ralIndex) {
        final add = carousalItems[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            width: screenWidth * 0.7,
            child: add['Images'],
          ),
        );
      },
      options: CarouselOptions(
          height: screenWidth * 0.4,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          viewportFraction: 0.8));
}

List<Map<String, dynamic>> carousalItems = [
  {
    'Images': Image.asset('asset/Diet_Plans_Images/foddItems_1.jpg',
        fit: BoxFit.cover)
  },
  {
    'Images': Image.asset('asset/Diet_Plans_Images/HealthyDiet1.jpg',
        fit: BoxFit.cover)
  },
  {
    'Images': Image.asset('asset/Diet_Plans_Images/HealthyDiet2.jpg',
        fit: BoxFit.cover)
  },
  {
    'Images': Image.asset('asset/Diet_Plans_Images/HealthyDiet3.jpg',
        fit: BoxFit.cover)
  }
];

// !BMI_Calculator_Screen_Carousal <><>
CarouselSlider bmiCalculatorCarousel(
    context, List<Map<String, dynamic>> carousalItemss) {
  final screenWidth = MediaQuery.of(context).size.width;

  return CarouselSlider.builder(
      itemCount: carousalItemss.length,
      itemBuilder: (context, index, ralIndex) {
        final add = carousalItemss[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            width: screenWidth * 0.7,
            child: add['Images'],
          ),
        );
      },
      options: CarouselOptions(
          height: screenWidth * 0.4,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          viewportFraction: 0.8));
}

List<Map<String, dynamic>> carousalItemss = [
  {
    'Images':
        Image.asset('asset/Diet_Plans_Images/BMI1.webp', fit: BoxFit.cover)
  },
  {
    'Images': Image.asset('asset/Diet_Plans_Images/bmi1.jpg', fit: BoxFit.cover)
  },
];

// ! BMI_Result_From_Calculation_Screen!!><>><><><>

Widget buildPersonalizedRecommendations(List<BmiCalculate> bmiCalculateList) {
  if (bmiCalculateList.isEmpty) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No BMI Calculation Found',
          style: GoogleFonts.jost(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: appcolorRed,
          ),
        ),
      ],
    );
  }

  // Get the most recent BMI calculation
  final latestBmiData = bmiCalculateList.last;

  return Padding(
    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Container(
      decoration: BoxDecoration(
        color: appcolorgrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Personalized Diet Recommendation',
            style: GoogleFonts.jost(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: appcolorgreen,
            ),
          ),
          Text(
            'BMI: ${latestBmiData.bmiresult?.toStringAsFixed(2)}',
            style: GoogleFonts.jost(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Category: ${latestBmiData.bmicategorry}',
            style: GoogleFonts.jost(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          // Text('${latestBmiData.timestamp}'),
          getDietRecommendation(latestBmiData.bmicategorry ?? ''),
        ],
      ),
    ),
  );
}

//  ! Meal_Food_Showing GridView><><><><

Widget buildMealTrackingSection(BuildContext context) {
  return const MealTrackingSection();
}

Widget customTextfield(
    String text, TextEditingController controller, Widget icon) {
  return Padding(
    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
    child: TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(), hintText: text, prefixIcon: icon),
      controller: controller,
    ),
  );
}
