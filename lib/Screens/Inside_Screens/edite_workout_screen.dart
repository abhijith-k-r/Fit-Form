// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously
import 'dart:io';
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/Screens/Inside_Screens/edit_profile.dart';
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
    if (selectedVideo != null) {
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
                        child: selectedImage != null
                            ? Image.file(
                                File(selectedImage!),
                                fit: BoxFit.cover,
                              )
                            : Column(
                                spacing: 8,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                  ),
                                  Text(
                                    'Click to upload ',
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
                      child: GestureDetector(
                        onTap: pickAndSetVideo,
                        child: selectedVideo == null
                            ? buildUploadPrompt()
                            : buildVideoPlayer(),
                      ),
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
                      value: _selectDifficulty,
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
    if (!isVideoInitialized || selectedVideo == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: appcolorblack,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        IconButton(
          icon: Icon(
            _videoController!.value.isPlaying ? null : Icons.play_arrow,
            color: appcolorwhite,
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
    );
  }
}
