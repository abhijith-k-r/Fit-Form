// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously
import 'dart:io';
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/features/profile/screens/edit_profile.dart';
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

late TextEditingController changeName;
late TextEditingController changeBenifits;
late TextEditingController changeSteps;
late TextEditingController changesets;
late TextEditingController changeRepeats;
late TextEditingController changeDuration;
late String? _selectDifficulty;
String? selectedImage;
String? selectedVideo;

class _EditeWorkoutState extends State<EditeWorkout> {
  VideoPlayerController? _videoController;
  bool isVideoInitialized = false;

  Future<void> initializeVideo() async {
    if (selectedVideo != null && File(selectedVideo!).existsSync()) {
      _videoController?.dispose();
      _videoController = VideoPlayerController.file(File(selectedVideo!));

      try {
        await _videoController!.initialize();
        setState(() {
          isVideoInitialized = true;
        });
        debugPrint('Video initialized successfully');
      } catch (e) {
        debugPrint('Error initializing video: $e');
        setState(() {
          isVideoInitialized = false;
        });
      }
    } else {
      setState(() {
        isVideoInitialized = false;
      });
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

  Future<void> pickAndSetImage() async {
    final imagePath = await pickImage();
    if (imagePath != null) {
      setState(() {
        selectedImage = imagePath;
      });
    }
  }

  @override
  void dispose() {
    changeName.dispose();
    changeBenifits.dispose();
    changeSteps.dispose();
    changesets.dispose();
    changeRepeats.dispose();
    changeDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EditWorkout'),
        ),
        body: ValueListenableBuilder(
          valueListenable: workoutsNotify,
          builder: (_, value, __) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel('Exercise Name'),
                    TextFormField(
                      controller: changeName,
                      decoration: InputDecoration(
                        hintText: 'e.g., Push-ups, Squats',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    // ! Adding_Exercise_Image
                    buildLabel('Exercise Image'),
                    GestureDetector(
                      onTap: pickAndSetImage,
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: appcolorgrey.shade300,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: (selectedImage != null &&
                                File(selectedImage!).existsSync())
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      File(selectedImage!),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.black.withOpacity(0.65),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.edit,
                                                size: 14,
                                                color: Colors.white),
                                            SizedBox(width: 4),
                                            Text(
                                              'Change',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                    color: appcolorgrey.shade400,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Click to upload Image',
                                    style: TextStyle(
                                      color: appcolorgrey.shade500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    // ! Benifts_Of_Workouts
                    buildLabel('Benefits'),
                    TextFormField(
                      controller: changeBenifits,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'List the benefits of this exercise...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),

                    //! How to Do Workouts
                    buildLabel('How to Do'),
                    TextFormField(
                      controller: changeSteps,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Step by step instructions...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    // !Video Uploaded
                    buildLabel('Workout Video '),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appcolorgrey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: selectedVideo == null
                          ? GestureDetector(
                              onTap: pickAndSetVideo,
                              child: buildUploadPrompt(),
                            )
                          : buildVideoPlayer(),
                    ),

                    Wrap(
                      spacing: 40,
                      runSpacing: 20,
                      children: [
                        buildNumberInput(
                            'Sets', Icons.fitness_center, '3', changesets),
                        buildNumberInput(
                            'Reps', Icons.repeat, '12', changeRepeats),
                        buildNumberInput('Duration (minutes)', Icons.timer, '5',
                            changeDuration),
                      ],
                    ),
                    buildLabel('Difficulty Level'),
                    DropdownButtonFormField<String>(
                      initialValue: _selectDifficulty,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: ['Beginner', 'Intermediate', 'Advanced']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          alignment: AlignmentDirectional.center,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectDifficulty = value;
                        });
                      },
                    ),

                    Row(
                      children: [
                        // ! Cancel Butoon For Workout_Edit SCreen 
                        cancelButtonForAddScreen(context),
                        // ! Edit And Save Butoon For Workout_Edit Screen
                        Expanded(
                          child: textButton(() async {
                            final updatedWorkout = WorkoutsModel(
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
                            editWorkout(widget.change.id!, updatedWorkout);
                            await getWorkouts();
                            workoutsNotify.notifyListeners();
                            Navigator.pop(context);
                          }, 'Edit Exercise', EdgeInsets.zero, appcolorgreen),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget buildVideoPlayer() {
    if (!isVideoInitialized || _videoController == null) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio > 0
                ? _videoController!.value.aspectRatio
                : 16 / 9,
            child: VideoPlayer(_videoController!),
          ),
          if (!_videoController!.value.isPlaying)
            Container(color: Colors.black38),
          IconButton(
            icon: Icon(
              _videoController!.value.isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
              color: appcolorwhite,
              size: 54,
            ),
            onPressed: () {
              setState(() {
                _videoController!.value.isPlaying
                    ? _videoController!.pause()
                    : _videoController!.play();
              });
            },
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: pickAndSetVideo,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.video_collection_outlined,
                        size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Change',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
