import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/delet_funcion.dart';
import 'package:fit_form/Screens/Inside_Screens/healthy_show.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/main.dart';
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
  final screenWidth = MediaQuery.of(context).size.width;

  return ValueListenableBuilder(
    valueListenable: healthyNotify,
    builder: (context, diets, child) {
      // Calculate total calories
      double totalCalories = diets.fold(
          0, (previous, current) => previous + current.healthcalories!);
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Calories: ${totalCalories.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Today\'s Meals',
            style: GoogleFonts.jost(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: screenWidth,
              height: (diets.length / 2).ceil() * (screenWidth / 2),
              child: GridView.builder(
                key: UniqueKey(),
                physics: ClampingScrollPhysics(),
                addAutomaticKeepAlives: false,
                // shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                ),
                itemCount: diets.length,
                itemBuilder: (context, index) {
                  final diet = diets[index];
                  final favoriteNotifier =
                      ValueNotifier<bool>(diet.favorite ?? false);

                  return Stack(
                    children: [
                      Container(
                        key: ValueKey(diet.id),
                        width: screenWidth * 0.8,
                        // height: screenWidth * 0.11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                isDark.value ? appcolorblack : appcolorwhite),

                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                radius: 20,
                                onLongPress: () => deletHealthy(context, index),
                                onTap: () => Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          HealthyDietShowScreen(
                                        diet: diet,
                                      ),
                                      transitionsBuilder: (context, animation,
                                              secondaryAnimation, child) =>
                                          FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                    )),
                                child: diet.healthimage != null
                                    ? Container(
                                        width: screenWidth * 0.5,
                                        height: screenWidth * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: FileImage(
                                                File(diet.healthimage!)),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: screenWidth * 0.5,
                                        height: screenWidth * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'asset/Diet_Plans_Images/HealthyDiet2.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: screenWidth * 0.05,
                              ),
                              Text(
                                diet.healthname ?? 'No Name',
                                style: GoogleFonts.jost(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: favoriteNotifier,
                            builder: (context, isFavorite, child) {
                              return IconButton(
                                  onPressed: () async {
                                    favoriteNotifier.value = !isFavorite;
                                    diet.favorite = favoriteNotifier.value;
                                    await editHealthyDiet(diet.id!, diet);
                                  },
                                  icon: Icon(
                                      diet.favorite == true
                                          ? Icons.favorite
                                          : Icons.favorite_outline_rounded,
                                      size: 23,
                                      color: diet.favorite == true
                                          ? appcolorpink
                                          : appcolorRed));
                            },
                          ))
                    ],
                  );
                },
              ),
            ))
      ]);
    },
  );
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
