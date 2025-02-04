// ignore_for_file: unused_field

import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/Timer/workout_timer.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class ShowWorkouts extends StatefulWidget {
  const ShowWorkouts({super.key, this.work});

  final WorkoutsModel? work;

  @override
  State<ShowWorkouts> createState() => _ShowWorkoutsState();
}

class _ShowWorkoutsState extends State<ShowWorkouts> {
  late VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    if (widget.work?.workoutvideo != null) {
      _videoController =
          VideoPlayerController.file(File(widget.work!.workoutvideo!))
            ..initialize().then((_) {
              setState(() {
                _isVideoInitialized = true;
              });
            });
    } else {
      _videoController = null;
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: widget.work!.workoutsImage != null
            ? Container(
                alignment: Alignment.bottomLeft,
                width: screenWidth,
                height: screenWidth * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(widget.work!.workoutsImage!)),
                    fit: BoxFit.fill,
                  ),
                ))
            : Container(
                alignment: Alignment.bottomLeft,
                width: screenWidth,
                height: screenWidth * 0.9,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'asset/Work_Outs_Images/BeginnerAi.webp',
                        ),
                        fit: BoxFit.cover)),
              ),
      ),
      Positioned(
          top: 40,
          left: 10,
          child: TextButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            label: Text(
              'Back',
              style: GoogleFonts.jost(
                  color: appcolorRed,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold),
            ),
            icon: Icon(Icons.arrow_back_ios_new, color: appcolorRed),
          )),
      Positioned(
          top: 290,
          left: 0,
          right: 0,
          child: Container(
            width: screenWidth,
            height: 630,
            decoration: BoxDecoration(
                color: isDark.value ? appcolorblack : appcolorwhite,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.work!.workoutsName!,
                        style: GoogleFonts.jost(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      FloatingActionButton(
                          onPressed: () async {
                            setState(() {
                              widget.work!.favorite =
                                  !(widget.work!.favorite ?? false);
                            });
                            await editWorkout(widget.work!.id!, widget.work!);
                          },
                          child: Icon(
                              widget.work!.favorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_outline_rounded,
                              size: 35,
                              color: widget.work!.favorite == true
                                  ? appcolorRed
                                  : appcolorRed))
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      workoutInfo(context, Icons.fitness_center_outlined,
                          widget.work!.numberOfSets!),
                      workoutInfo(
                          context, Icons.repeat_outlined, widget.work!.reps!),
                      workoutInfo(context, Icons.timer, widget.work!.duration!),
                    ],
                  )
                ],
              ),
            ),
          )),
      Positioned(
          top: 390,
          left: 15,
          right: 15,
          bottom: 0,
          child: Container(
            color: isDark.value ? appcolorblack : appcolorwhite,
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth,
                    height: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appcolorgrey,
                    ),
                    child: _isVideoInitialized
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                child: AspectRatio(
                                  aspectRatio:
                                      _videoController!.value.aspectRatio,
                                  child: VideoPlayer(_videoController!),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _videoController!.value.isPlaying
                                      ? null
                                      : Icons.play_arrow,
                                  color: appcolorRed,
                                  size: 50,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _videoController!.value.isPlaying
                                        ? _videoController!.pause()
                                        : _videoController!.play();
                                  });
                                },
                              ),
                            ],
                          )
                        : Center(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: appcolorwhite,
                              child: Icon(
                                Icons.play_arrow,
                                size: 40,
                                color: appcolorRed,
                              ),
                            ),
                          ),
                  ),
                  workoutsection(context, Icons.info_outline, 'Benefits'),
                  Text(
                    widget.work!.benifits!,
                    style: GoogleFonts.alegreyaSansSc(
                        fontSize: screenWidth * 0.05),
                  ),
                  workoutsection(context, Icons.menu_book, 'How to Do'),
                  Text(
                    widget.work!.woroutSteps!,
                    style: GoogleFonts.alegreyaSansSc(
                        fontSize: screenWidth * 0.05),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      WorkoutTimer(
                                workColor: appcolorRed,
                                restColor: appcolorgreen,
                                backgroundColor: appcolorwhite,
                                circularProgressSize: 250.0,
                              ),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appcolorRed,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Start Workout',
                          style: GoogleFonts.jost(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: appcolorwhite)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )),
    ]));
  }
}


