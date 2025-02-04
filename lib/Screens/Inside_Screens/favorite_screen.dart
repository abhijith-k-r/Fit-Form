import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/delet_funcion.dart';
import 'package:fit_form/Screens/Inside_Screens/show_workouts.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: GoogleFonts.jost(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: workoutsNotify,
        builder: (context, List<WorkoutsModel> workouts, child) {
          List<WorkoutsModel> favoriteWorkouts =
              workouts.where((workout) => workout.favorite == true).toList();

          return favoriteWorkouts.isEmpty
              ? Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [appcolorpink, appcoloryellow],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'No favorite workouts yet.',
                      style: GoogleFonts.jost(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: appcolorwhite),
                    ),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemCount: favoriteWorkouts.length,
                  itemBuilder: (context, index) {
                    final workout = favoriteWorkouts[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ShowWorkouts(work: workout),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          )),
                      child: Card(
                          child: Column(children: [
                        Container(
                            width: screenWidth,
                            height: screenWidth * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                image: (workout.workoutsImage != null &&
                                        File(workout.workoutsImage!)
                                            .existsSync())
                                    ? DecorationImage(
                                        image: FileImage(
                                            File(workout.workoutsImage!)),
                                        fit: BoxFit.fill)
                                    : null),
                            child: (workout.workoutsImage == null ||
                                    !File(workout.workoutsImage!).existsSync())
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.asset(
                                        'asset/Work_Outs_Images/BeginnerAi.webp',
                                        fit: BoxFit.cover))
                                : null),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(workout.workoutsName ?? '',
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03)),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await deletFAvorite(context, workout);
                                  },
                                  icon: Icon(
                                      workout.favorite == true
                                          ? Icons.favorite
                                          : Icons.favorite_outline_rounded,
                                      color: workout.favorite == true
                                          ? appcolorRed
                                          : appcolorRed))),
                        )
                      ])),
                    );
                  },
                );
        },
      ),
    );
  }
}
