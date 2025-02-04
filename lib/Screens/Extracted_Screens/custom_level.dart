import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/delet_funcion.dart';
import 'package:fit_form/Screens/Inside_Screens/edite_workout_screen.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//! Beginner_TabBar_Contents >< <> ><

class BeginnerTabBar extends StatelessWidget {
  const BeginnerTabBar({
    super.key,
    required this.currentQuery,
  });

  final String currentQuery;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: workoutsNotify,
      builder: (context, value, child) {
        List<WorkoutsModel> beginnerworkouts =
            getWorkoutsByDifficulty("Beginner")
                .where((workout) =>
                    workout.workoutsName!.toLowerCase().contains(currentQuery))
                .toList();
        if (beginnerworkouts.isEmpty) {
          return Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [appcolorpink, appcoloryellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'Create Beginner workouts.',
                style: GoogleFonts.jost(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: appcolorwhite),
              ),
            ),
          );
        }
        return ListView.builder(
            itemCount: beginnerworkouts.length,
            itemBuilder: (context, index) {
              final workout = beginnerworkouts[index];
              return ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditeWorkout(
                        change: workout,
                      ),
                    )),
                onLongPress: () async {
                  deletePopup(context, workout, workout.id!);
                },
                leading: workout.workoutsImage != null
                    ? Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(File(workout.workoutsImage!)),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appcolorgrey,
                        ),
                        child: Icon(Icons.fitness_center),
                      ),
                title: Text(workout.workoutsName!,
                    style: GoogleFonts.jost(fontWeight: FontWeight.bold)),
                subtitle: Text('${workout.numberOfSets} X' ' ${workout.reps}',
                    style: GoogleFonts.jost(
                        fontWeight: FontWeight.w700, color: appcolorRed)),
                trailing: Text(
                  "Beginner",
                  style: TextStyle(color: appcolorblue),
                ),
              );
            });
      },
    );
  }
}

//! InterMediate_TabBar_Contents >< <> ><

class IntermediateTabBar extends StatelessWidget {
  const IntermediateTabBar({super.key, required this.currntQuery});

  final String currntQuery;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: workoutsNotify,
      builder: (context, value, child) {
        List<WorkoutsModel> intermediateWorkouts =
            getWorkoutsByDifficulty("Intermediate")
                .where((workout) =>
                    workout.workoutsName!.toLowerCase().contains(currntQuery))
                .toList();
        if (intermediateWorkouts.isEmpty) {
          return Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [appcolorpink, appcoloryellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'Create intermediate workouts.',
                style: GoogleFonts.jost(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: appcolorwhite),
              ),
            ),
          );
        }
        return ListView.builder(
            itemCount: intermediateWorkouts.length,
            itemBuilder: (context, index) {
              final workout = intermediateWorkouts[index];
              return ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditeWorkout(
                        change: workout,
                      ),
                    )),
                onLongPress: () async =>
                    deletePopup(context, workout, workout.id!),
                leading: workout.workoutsImage != null
                    ? Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(File(workout.workoutsImage!)),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appcolorgrey,
                        ),
                        child: Icon(Icons.fitness_center),
                      ),
                title: Text(workout.workoutsName!,
                    style: GoogleFonts.jost(fontWeight: FontWeight.bold)),
                subtitle: Text('${workout.numberOfSets} X' ' ${workout.reps}',
                    style: GoogleFonts.jost(
                        fontWeight: FontWeight.w700, color: appcolorRed)),
                trailing: Text(
                  "Intermediate",
                  style: TextStyle(color: appcoloryellow),
                ),
              );
            });
      },
    );
  }
}

//! Advaced_TabBar_Contents >< <> ><

class AdvacedTabBar extends StatelessWidget {
  const AdvacedTabBar({super.key, required this.currntQuery});

  final String currntQuery;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: workoutsNotify,
      builder: (context, value, child) {
        List<WorkoutsModel> advacedWorkouts =
            getWorkoutsByDifficulty("Advanced")
                .where((workout) =>
                    workout.workoutsName!.toLowerCase().contains(currntQuery))
                .toList();
        if (advacedWorkouts.isEmpty) {
          return Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [appcolorpink, appcoloryellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'Create Advanced workouts.',
                style: GoogleFonts.jost(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: appcolorwhite),
              ),
            ),
          );
        }
        return ListView.builder(
            itemCount: advacedWorkouts.length,
            itemBuilder: (context, index) {
              final workout = advacedWorkouts[index];
              return ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditeWorkout(
                              change: workout,
                            ))),
                onLongPress: () => deletePopup(context, workout, workout.id!),
                leading: workout.workoutsImage != null
                    ? Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(File(workout.workoutsImage!)),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appcolorgrey,
                        ),
                        child: Icon(Icons.fitness_center),
                      ),
                title: Text(workout.workoutsName!,
                    style: GoogleFonts.jost(fontWeight: FontWeight.bold)),
                subtitle: Text('${workout.numberOfSets} X' ' ${workout.reps}',
                    style: GoogleFonts.jost(
                        fontWeight: FontWeight.w700, color: appcolorRed)),
                trailing: Text(
                  "Advaced",
                  style: TextStyle(color: appcolorRed),
                ),
              );
            });
      },
    );
  }
}
