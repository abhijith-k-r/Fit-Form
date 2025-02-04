// ignore_for_file: use_build_context_synchronously, invalid_use_of_visible_for_testing_member

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> deletePopup(
    BuildContext context, WorkoutsModel work, String id) async {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text(
                'Are you Sure\nDelete this?',
                textAlign: TextAlign.center,
              ),
              actions: [
                Center(
                    child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        deleteWorkout(id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Delete',
                        style: GoogleFonts.jost(
                          color: appcolorRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.jost(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ))
              ]));
}

// !DeletWorkoutFavorite<>>><>><><><><><

Future<void> deletFAvorite(BuildContext context, WorkoutsModel workout) async {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text(
                'Are you Sure\n Remove this?',
                textAlign: TextAlign.center,
              ),
              actions: [
                Center(
                    child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        workout.favorite = false;
                        await editWorkout(workout.id!, workout);
                        workoutsNotify.value = workoutsNotify.value.toList();
                        workoutsNotify.notifyListeners();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Remove',
                        style: GoogleFonts.jost(
                          color: appcolorRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.jost(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ))
              ]));
}

// !Delet_HealthyDiet_Favorites<><><><><>>
Future<void> deletHealthyDietFAvorite(
    BuildContext context, HealtyDiet Diet) async {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text(
                'Are you Sure\n Remove this?',
                textAlign: TextAlign.center,
              ),
              actions: [
                Center(
                    child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        Diet.favorite = false;
                        await editHealthyDiet(Diet.id!, Diet);
                        healthyNotify.value = healthyNotify.value.toList();
                        healthyNotify.notifyListeners();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Remove',
                        style: GoogleFonts.jost(
                          color: appcolorRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.jost(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ))
              ]));
}

// ! Calculated BMI Deleting<><><><
Future<void> calculateDelet(BuildContext context,
    Box<BmiCalculate> bmiCalculateBox, Function() loadBmiHistory) async {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text(
                'Are you Sure\n Clear BMI?',
                textAlign: TextAlign.center,
              ),
              actions: [
                Center(
                    child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        bmiCalculateBox.clear();
                        loadBmiHistory();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Clear',
                        style: GoogleFonts.jost(
                          color: appcolorRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.jost(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ))
              ]));
}

Future<void> deletHealthy(BuildContext context, int id) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: const Text(
          'Are you Sure\n Delete This?',
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
              child: Column(
            children: [
              TextButton(
                onPressed: () {
                  deletDiet(id);
                  Navigator.pop(context);
                },
                child: Text(
                  'Delete',
                  style: GoogleFonts.jost(
                    color: appcolorRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.jost(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ))
        ]),
  );
}
