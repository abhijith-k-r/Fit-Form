// ignore_for_file: use_build_context_synchronously, must_be_immutable, unnecessary_null_comparison, unused_field
import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/Screens/Inside_Screens/widgets/add_workout_form_fields.dart';
import 'package:fit_form/Screens/Inside_Screens/widgets/workout_media_pickers.dart';
import 'package:fit_form/Screens/Inside_Screens/widgets/workout_steps_input.dart';
import 'package:fit_form/core/services/media_picker_service.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AddworkoutScreen extends StatefulWidget {
  AddworkoutScreen({super.key, this.id});

  final String? id;

  final TextEditingController _workoutNameController = TextEditingController();
  final TextEditingController _benifitController = TextEditingController();
  final TextEditingController _workoutSetsController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  @override
  State<AddworkoutScreen> createState() => _AddworkoutScreenState();
}

class _AddworkoutScreenState extends State<AddworkoutScreen> {
  final List<TextEditingController> stepcontroller = [];
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
    getWorkouts();
    addStep();
  }

  @override
  void dispose() {
    for (var controller in stepcontroller) {
      controller.dispose();
    }
    _videoController?.dispose();
    super.dispose();
  }

  void addStep() {
    setState(() => stepcontroller.add(TextEditingController()));
  }

  void removeSteps(int index) {
    if (stepcontroller.length > 1) {
      setState(() {
        stepcontroller[index].dispose();
        stepcontroller.removeAt(index);
      });
    } else {
      snackBarMessenger(context, 'At least one step is required.', appcolorRed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Exercise',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
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

              // How to Do Steps
              WorkoutStepsInput(
                stepControllers: stepcontroller,
                onAddStep: addStep,
                onRemoveStep: removeSteps,
              ),

              // Form fields
              AddWorkoutFormFields(
                nameController: widget._workoutNameController,
                benefitController: widget._benifitController,
                setsController: widget._workoutSetsController,
                repeatController: widget._repeatController,
                durationController: widget._durationController,
                difficulty: _selectDifficulty,
                onDifficultyChanged: (val) =>
                    setState(() => _selectDifficulty = val),
              ),

              // Action Buttons
              Row(
                spacing: 15,
                children: [
                  cancelButtonForAddScreen(context),
                  addingButtonForAddScreen(
                    context,
                    widget._workoutNameController,
                    widget._durationController,
                    saveWorkout,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveWorkout() {
    final steps = stepcontroller.map((controller) => controller.text).toList();
    if (steps.any((steps) => steps.isEmpty)) {
      snackBarMessenger(context, "'Please fill all steps.'", appcolorRed);
      return;
    }
    final saveworkout = WorkoutsModel(
      workoutsName: widget._workoutNameController.text,
      woroutSteps: steps.join('\n'),
      benifits: widget._benifitController.text,
      numberOfSets: widget._workoutSetsController.text,
      reps: widget._repeatController.text,
      duration: widget._durationController.text,
      difficulty: _selectDifficulty,
      workoutsImage: selectedImage,
      workoutvideo: selectedVideo,
    );
    addWorkout(saveworkout);
    getWorkouts();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    workoutsNotify.notifyListeners();
    Navigator.pop(context);
  }
}
