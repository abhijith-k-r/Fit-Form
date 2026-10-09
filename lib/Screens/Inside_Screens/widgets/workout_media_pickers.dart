import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WorkoutImageUploadBox extends StatelessWidget {
  const WorkoutImageUploadBox({
    super.key,
    required this.selectedImage,
    required this.onPickImage,
  });

  final String? selectedImage;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    final hasValidImg =
        selectedImage != null && File(selectedImage!).existsSync();

    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: hasValidImg
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
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.edit, size: 14, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'Change',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
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
                  Icon(Icons.image, size: 40, color: Colors.grey.shade400),
                  const SizedBox(height: 8),
                  Text(
                    'Click to upload Image',
                    style:
                        TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
      ),
    );
  }
}

class WorkoutVideoUploadBox extends StatefulWidget {
  const WorkoutVideoUploadBox({
    super.key,
    required this.selectedVideo,
    required this.videoController,
    required this.isVideoInitialized,
    required this.onPickVideo,
  });

  final String? selectedVideo;
  final VideoPlayerController? videoController;
  final bool isVideoInitialized;
  final VoidCallback onPickVideo;

  @override
  State<WorkoutVideoUploadBox> createState() => _WorkoutVideoUploadBoxState();
}

class _WorkoutVideoUploadBoxState extends State<WorkoutVideoUploadBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: widget.selectedVideo == null
          ? GestureDetector(
              onTap: widget.onPickVideo,
              child: buildUploadPrompt(),
            )
          : _buildPlayer(),
    );
  }

  Widget _buildPlayer() {
    if (!widget.isVideoInitialized || widget.videoController == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final controller = widget.videoController!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio > 0
                ? controller.value.aspectRatio
                : 16 / 9,
            child: VideoPlayer(controller),
          ),
          if (!controller.value.isPlaying) Container(color: Colors.black38),
          IconButton(
            icon: Icon(
              controller.value.isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
              color: appcolorwhite,
              size: 54,
            ),
            onPressed: () {
              setState(() {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              });
            },
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: widget.onPickVideo,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
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
                        fontWeight: FontWeight.bold,
                      ),
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
