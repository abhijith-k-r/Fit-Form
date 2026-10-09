// ignore_for_file: use_build_context_synchronously, must_be_immutable, unnecessary_null_comparison, unused_field, invalid_use_of_visible_for_testing_member
import 'dart:io';
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/features/profile/screens/edit_profile.dart';
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
  String? _selectDifficulty;
  String? selectedImage;
  String? selectedVideo;
  VideoPlayerController? _videoController;
  bool isVideoInitialized = false;

  List<TextEditingController> stepcontroller = [];

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

  Future<void> pickAndSetImage() async {
    final imagePath = await pickImage();
    if (imagePath != null) {
      setState(() {
        selectedImage = imagePath;
      });
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
    setState(() {
      stepcontroller.add(TextEditingController());
    });
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
          title: Text(
            'Add New Exercise',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ValueListenableBuilder<List<WorkoutsModel>>(
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
                            controller: widget._workoutNameController,
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
                                  color: Colors.grey.shade300,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.65),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 40,
                                          color: Colors.grey.shade400,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Click to upload Image',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
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
                            controller: widget._benifitController,
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
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: stepcontroller.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: TextFormField(
                                          controller: stepcontroller[index],
                                          decoration: InputDecoration(
                                            hintText: 'Step ${index + 1}',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          )),
                                    ),
                                  ),
                                  IconButton(
                                    icon:
                                        const Icon(Icons.remove_circle_outline),
                                    onPressed: () => removeSteps(index),
                                  ),
                                ],
                              );
                            },
                          ),
                          //  ! It's For Dynamic _View Adding _Text Field !!
                          dymaicViewofSteps(addStep),

                          // !Video Uploaded
                          buildLabel('Workout Video '),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
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
                          // ! Sets||Reps||Dutation
                          workoutAddingWrapedContents(
                              widget._workoutSetsController,
                              widget._repeatController,
                              widget._durationController),

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
                          Row(spacing: 15, children: [
                            // !Canecl Button
                            cancelButtonForAddScreen(context),
                            addingButtonForAddScreen(
                                context,
                                widget._workoutNameController,
                                widget._durationController,
                                saveWorkout)
                          ])
                        ])));
          },
        ));
  }

  Widget buildVideoPlayer() {
    if (!isVideoInitialized || _videoController == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
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
        workoutvideo: selectedVideo);
    addWorkout(saveworkout);
    getWorkouts();
    workoutsNotify.notifyListeners();
    Navigator.pop(context);
  }
}
