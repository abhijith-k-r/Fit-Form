// ignore_for_file: sort_child_properties_last, no_leading_underscores_for_local_identifiers, empty_catches, unused_field, unused_element

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/diet_planner.dart';
import 'package:fit_form/Screens/Inside_Screens/add_healty_diets.dart';
import 'package:fit_form/Screens/Inside_Screens/healty_favorite.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HealthyDietPlannerScreen extends StatefulWidget {
  const HealthyDietPlannerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HealthyDietPlannerScreenState createState() =>
      _HealthyDietPlannerScreenState();
}

class _HealthyDietPlannerScreenState extends State<HealthyDietPlannerScreen> {
  List<BmiCalculate> _bmiCalculateList = [];

  @override
  void initState() {
    super.initState();
    _loadbmiHistory();
    healthyDietInitialize();
  }

  void _loadbmiHistory() async {
    try {
      final bmicalculatBox =
          await Hive.openBox<BmiCalculate>('bmiCalculations');
      setState(() {
        _bmiCalculateList = bmicalculatBox.values.toList();
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final latestBmiData =
        _bmiCalculateList.isNotEmpty ? _bmiCalculateList.last : null;
    final bmiCategory = latestBmiData?.bmicategorry ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Healthy Diet Planner',
          style: GoogleFonts.jost(fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! Personalized Recommendations Section
            buildPersonalizedRecommendations(_bmiCalculateList),

            //! Diet Categories Section
            predefinedDietCategories(context, bmiCategory),

            //! Meal Tracking Section
            buildMealTrackingSection(context)
          ],
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: FloatingActionButton(
                heroTag: 'addDiet',
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            AddHealtyDiets(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ));
                },
                child: Icon(Icons.add),
                backgroundColor: appcolorRed),
          ),
          Positioned(
              bottom: 80,
              right: 5,
              child: FloatingActionButton(
                heroTag: 'favoriteDiet',
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            HealthyFavorite(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ));
                },
                backgroundColor: appcolorwhite,
                child: Icon(
                  Icons.favorite,
                  color: appcolorRed,
                ),
                mini: true,
              ))
        ],
      ),
    );
  }
}








