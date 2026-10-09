// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/Screens/Inside_Screens/widgets/edit_workout_form_fields.dart';
import 'package:fit_form/Screens/Inside_Screens/widgets/workout_media_pickers.dart';
import 'package:fit_form/core/services/media_picker_service.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EditeWorkout extends StatefulWidget {
  const EditeWorkout({super.key, required this.change});

  final WorkoutsModel change;

  @override
  State<EditeWorkout> createState() => _EditeWorkoutState();
}

class _EditeWorkoutState extends State<EditeWorkout> {
  late TextEditingController changeName;
  late TextEditingController changeBenifits;
  late TextEditingController changeSteps;
  late TextEditingController changesets;
  late TextEditingController changeRepeats;
  late TextEditingController changeDuration;

  String? _selectDifficulty;
  String? selectedImage;
  String? selectedVideo;
  VideoPlayerController? _videoController;
  bool isVideoInitialized = false;

  Future<void> initializeVideo() async {
    if (selectedVideo != null && File(selectedVideo!).existsSync()) {
      _videoController?.dispose();
      _videoController = VideoPlayerController.file(File(selectedVideo!));
      try {
        await _videoController!.initialize();
        setState(() => isVideoInitialized = true);
      } catch (e) {
        setState(() => isVideoInitialized = false);
      }
    } else {
      setState(() => isVideoInitialized = false);
    }
  }

  Future<void> pickAndSetVideo() async {
    final videoPath = await pickVideo();
    if (videoPath != null) {
      setState(() {
        selectedVideo = videoPath;
        isVideoInitialized = false;
      });
      await initializeVideo();
    }
  }

  Future<void> pickAndSetImage() async {
    final imagePath = await pickImage();
    if (imagePath != null) {
      setState(() => selectedImage = imagePath);
    }
  }

  @override
  void initState() {
    super.initState();
    changeName = TextEditingController(text: widget.change.workoutsName);
    changeBenifits = TextEditingController(text: widget.change.benifits);
    changeSteps = TextEditingController(text: widget.change.woroutSteps);
    changesets = TextEditingController(text: widget.change.numberOfSets);
    changeRepeats = TextEditingController(text: widget.change.reps);
    changeDuration = TextEditingController(text: widget.change.duration);
    _selectDifficulty = widget.change.difficulty;
    selectedImage = widget.change.workoutsImage;
    selectedVideo = widget.change.workoutvideo;
    if (selectedVideo != null) {
      initializeVideo();
    }
    getWorkouts();
  }

  @override
  void dispose() {
    changeName.dispose();
    changeBenifits.dispose();
    changeSteps.dispose();
    changesets.dispose();
    changeRepeats.dispose();
    changeDuration.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Workout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exercise Image Box
              buildLabel('Exercise Image'),
              WorkoutImageUploadBox(
                selectedImage: selectedImage,
                onPickImage: pickAndSetImage,
              ),

              // Workout Video Box
              buildLabel('Workout Video'),
              WorkoutVideoUploadBox(
                selectedVideo: selectedVideo,
                videoController: _videoController,
                isVideoInitialized: isVideoInitialized,
                onPickVideo: pickAndSetVideo,
              ),

              // Form fields
              EditWorkoutFormFields(
                nameController: changeName,
                benefitsController: changeBenifits,
                stepsController: changeSteps,
                setsController: changesets,
                repeatsController: changeRepeats,
                durationController: changeDuration,
                difficulty: _selectDifficulty,
                onDifficultyChanged: (val) =>
                    setState(() => _selectDifficulty = val),
              ),

              // Action buttons
              Row(
                children: [
                  cancelButtonForAddScreen(context),
                  Expanded(
                    child: textButton(() async {
                      final updated = WorkoutsModel(
                        id: widget.change.id,
                        workoutsName: changeName.text,
                        benifits: changeBenifits.text,
                        woroutSteps: changeSteps.text,
                        numberOfSets: changesets.text,
                        reps: changeRepeats.text,
                        duration: changeDuration.text,
                        difficulty: _selectDifficulty,
                        workoutsImage: selectedImage,
                        workoutvideo: selectedVideo,
                      );
                      editWorkout(widget.change.id!, updated);
                      await getWorkouts();
                      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                      workoutsNotify.notifyListeners();
                      Navigator.pop(context);
                    }, 'Edit Exercise', EdgeInsets.zero, appcolorgreen),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
