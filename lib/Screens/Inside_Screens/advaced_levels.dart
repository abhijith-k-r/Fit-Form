import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/appbarcustom.dart';
import 'package:fit_form/Screens/Inside_Screens/show_workouts.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedLevels extends StatefulWidget {
  const AdvancedLevels({super.key});

  @override
  State<AdvancedLevels> createState() => _AdvancedLevelsState();
}

class _AdvancedLevelsState extends State<AdvancedLevels> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.bottomLeft,
                width: double.infinity,
                height: 320,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'asset/Work_Outs_Images/AdvancedAi.webp',
                        ),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAppbar(
                          searchController: _searchController,
                          onChanged: (value) => setState(() {
                                searchQuery = value.toLowerCase();
                              })),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Time to Get Moving\n',
                              style: GoogleFonts.jost(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Advanced Level \n',
                                    style: GoogleFonts.fredoka(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    )),
                                TextSpan(
                                    text: 'Workouts',
                                    style: GoogleFonts.fredoka(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ))
                              ])),
                    ],
                  ),
                )),
          ),
          Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 630,
                decoration: BoxDecoration(
                    color: isDark.value ? appcolorblack : appcolorwhite,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20))),
              )),
          Positioned(
              top: 310,
              left: 15,
              right: 15,
              bottom: 0,
              child: Material(
                  color: isDark.value ? appcolorblack : appcolorwhite,
                  child: ValueListenableBuilder(
                    valueListenable: workoutsNotify,
                    builder: (context, value, child) {
                      List<WorkoutsModel> advacedWorkouts =
                          getWorkoutsByDifficulty("Advanced")
                              .where((workout) => workout.workoutsName!
                                  .toLowerCase()
                                  .contains(searchQuery))
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
                              'No Advaced workouts available.',
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
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      ShowWorkouts(work: workout),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                )),
                            leading: Container(
                                width: 60,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.amber[300],
                                    image: (workout.workoutsImage != null &&
                                            File(workout.workoutsImage!)
                                                .existsSync())
                                        ? DecorationImage(
                                            image: FileImage(
                                                File(workout.workoutsImage!)),
                                            fit: BoxFit.fill)
                                        : null),
                                child: (workout.workoutsImage == null ||
                                        !File(workout.workoutsImage!)
                                            .existsSync())
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.asset(
                                            'asset/Work_Outs_Images/AdvancedAi.webp',
                                            fit: BoxFit.cover))
                                    : null),
                            title: Text(workout.workoutsName!,
                                style: GoogleFonts.jost(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                '${workout.numberOfSets} X' ' ${workout.reps}',
                                style: GoogleFonts.jost(
                                    fontWeight: FontWeight.w700,
                                    color: appcolorRed)),
                            trailing: CircleAvatar(
                              child: IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      workout.favorite =
                                          !(workout.favorite ?? false);
                                    });
                                    await editWorkout(workout.id!, workout);
                                  },
                                  icon: Icon(
                                      workout.favorite == true
                                          ? Icons.favorite
                                          : Icons.favorite_outline_rounded,
                                      color: workout.favorite == true
                                          ? appcolorRed
                                          : appcolorRed)),
                            ),
                          );
                        },
                      );
                    },
                  ))),
        ],
      ),
    );
  }
}
