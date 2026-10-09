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
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // MX Player style gesture scrubbing states
  bool _isDragging = false;
  Duration _dragTargetPosition = Duration.zero;
  Duration _dragStartPosition = Duration.zero;
  double _dragAccumulatedDx = 0;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  void _initVideo() {
    final videoPath = widget.work?.workoutvideo;
    if (videoPath != null && videoPath.isNotEmpty && File(videoPath).existsSync()) {
      _videoController = VideoPlayerController.file(File(videoPath))
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isVideoInitialized = true;
              _totalDuration = _videoController!.value.duration;
            });
            _videoController!.addListener(() {
              if (mounted && _videoController != null && !_isDragging) {
                setState(() {
                  _currentPosition = _videoController!.value.position;
                });
              }
            });
          }
        }).catchError((e) {
          debugPrint('Video player init error: $e');
          if (mounted) {
            setState(() {
              _isVideoInitialized = false;
            });
          }
        });
    } else {
      _videoController = null;
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _seekForward() {
    if (_videoController == null) return;
    final target = _currentPosition + const Duration(seconds: 10);
    _videoController!.seekTo(target > _totalDuration ? _totalDuration : target);
  }

  void _seekBackward() {
    if (_videoController == null) return;
    final target = _currentPosition - const Duration(seconds: 10);
    _videoController!.seekTo(target < Duration.zero ? Duration.zero : target);
  }

  void _restartVideo() {
    if (_videoController == null) return;
    _videoController!.seekTo(Duration.zero);
    _videoController!.play();
    setState(() {});
  }

  ImageProvider _getImageProvider(String? imagePath, String? difficulty) {
    if (imagePath != null && imagePath.isNotEmpty) {
      if (imagePath.startsWith('asset/') || imagePath.startsWith('assets/')) {
        return AssetImage(imagePath);
      }
      final file = File(imagePath);
      if (file.existsSync()) {
        return FileImage(file);
      }
    }
    if (difficulty == 'Intermediate') {
      return const AssetImage('asset/Work_Outs_Images/IntermediateAi.webp');
    } else if (difficulty == 'Advanced') {
      return const AssetImage('asset/Work_Outs_Images/AdvancedAi.webp');
    }
    return const AssetImage('asset/Work_Outs_Images/BeginnerAi.webp');
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = isDark.value;

    return Scaffold(
      backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
      body: CustomScrollView(
        slivers: [
          // Header App Bar with Background Workout Image
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            elevation: 2,
            backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: (isDarkMode ? Colors.black : Colors.white).withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back_ios_new, color: appcolorRed, size: 18),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: (isDarkMode ? Colors.black : Colors.white).withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.work?.favorite == true
                        ? Icons.favorite
                        : Icons.favorite_outline_rounded,
                    color: appcolorRed,
                    size: 20,
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    widget.work?.favorite = !(widget.work?.favorite ?? false);
                  });
                  if (widget.work?.id != null) {
                    await editWorkout(widget.work!.id!, widget.work!);
                  }
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image(
                    image: _getImageProvider(
                      widget.work?.workoutsImage,
                      widget.work?.difficulty,
                    ),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'asset/Work_Outs_Images/BeginnerAi.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          (isDarkMode ? appcolorblack : appcolorwhite).withOpacity(0.9),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Workout Body: Details, MX-Player Video, Instructions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Difficulty Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.work?.workoutsName ?? 'Exercise',
                          style: GoogleFonts.jost(
                            fontSize: screenWidth * 0.058,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? appcolorwhite : appcolorblack,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: appcolorRed.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.work?.difficulty ?? 'Beginner',
                          style: GoogleFonts.jost(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: appcolorRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Sets, Reps, Duration row
                  Row(
                    children: [
                      workoutInfo(
                        context,
                        Icons.fitness_center_outlined,
                        widget.work?.numberOfSets ?? '3 Sets',
                      ),
                      const SizedBox(width: 8),
                      workoutInfo(
                        context,
                        Icons.repeat_outlined,
                        widget.work?.reps ?? '12 Reps',
                      ),
                      const SizedBox(width: 8),
                      workoutInfo(
                        context,
                        Icons.timer,
                        widget.work?.duration ?? '45s',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Interactive Video Player (MX Player style gesture scrolling & controls)
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isDarkMode
                          ? const Color.fromARGB(255, 24, 24, 24)
                          : Colors.grey[900],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: _isVideoInitialized && _videoController != null
                        ? Column(
                            children: [
                              // Video surface with MX Player horizontal drag gesture
                              GestureDetector(
                                onHorizontalDragStart: (details) {
                                  if (_videoController == null || !_isVideoInitialized) return;
                                  setState(() {
                                    _isDragging = true;
                                    _dragStartPosition = _currentPosition;
                                    _dragTargetPosition = _currentPosition;
                                    _dragAccumulatedDx = 0;
                                  });
                                },
                                onHorizontalDragUpdate: (details) {
                                  if (_videoController == null || !_isVideoInitialized) return;
                                  setState(() {
                                    _dragAccumulatedDx += details.primaryDelta ?? 0;
                                    final offsetMs = (_dragAccumulatedDx * 80).toInt();
                                    final newPos = _dragStartPosition + Duration(milliseconds: offsetMs);
                                    if (newPos < Duration.zero) {
                                      _dragTargetPosition = Duration.zero;
                                    } else if (newPos > _totalDuration) {
                                      _dragTargetPosition = _totalDuration;
                                    } else {
                                      _dragTargetPosition = newPos;
                                    }
                                  });
                                },
                                onHorizontalDragEnd: (details) {
                                  if (_videoController == null || !_isVideoInitialized) return;
                                  _videoController!.seekTo(_dragTargetPosition);
                                  setState(() {
                                    _isDragging = false;
                                    _currentPosition = _dragTargetPosition;
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    _videoController!.value.isPlaying
                                        ? _videoController!.pause()
                                        : _videoController!.play();
                                  });
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: _videoController!.value.aspectRatio > 0
                                          ? _videoController!.value.aspectRatio
                                          : 16 / 9,
                                      child: VideoPlayer(_videoController!),
                                    ),
                                    // MX Player gesture feedback HUD
                                    if (_isDragging)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.75),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              _dragTargetPosition >= _dragStartPosition
                                                  ? Icons.fast_forward
                                                  : Icons.fast_rewind,
                                              color: appcolorRed,
                                              size: 36,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${_formatDuration(_dragTargetPosition)} / ${_formatDuration(_totalDuration)}',
                                              style: GoogleFonts.jost(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${(_dragTargetPosition - _dragStartPosition).inSeconds >= 0 ? '+' : ''}${(_dragTargetPosition - _dragStartPosition).inSeconds}s',
                                              style: GoogleFonts.jost(
                                                color: appcolorRed,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    // Play icon overlay when paused
                                    if (!_videoController!.value.isPlaying && !_isDragging)
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          color: Colors.black45,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.white,
                                          size: 46,
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              // Bottom Controls Bar (Slider + Buttons)
                              Container(
                                color: Colors.black.withOpacity(0.85),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                child: Column(
                                  children: [
                                    // Horizontal Scrubbing Slider (like MX Player)
                                    Row(
                                      children: [
                                        Text(
                                          _formatDuration(_currentPosition),
                                          style: GoogleFonts.jost(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Expanded(
                                          child: SliderTheme(
                                            data: SliderTheme.of(context).copyWith(
                                              activeTrackColor: appcolorRed,
                                              inactiveTrackColor: Colors.white24,
                                              thumbColor: appcolorRed,
                                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                              trackHeight: 3,
                                            ),
                                            child: Slider(
                                              value: _currentPosition.inMilliseconds
                                                  .toDouble()
                                                  .clamp(0.0, _totalDuration.inMilliseconds.toDouble()),
                                              min: 0.0,
                                              max: _totalDuration.inMilliseconds > 0
                                                  ? _totalDuration.inMilliseconds.toDouble()
                                                  : 1.0,
                                              onChanged: (val) {
                                                _videoController!.seekTo(
                                                  Duration(milliseconds: val.toInt()),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _formatDuration(_totalDuration),
                                          style: GoogleFonts.jost(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Action Buttons: Restart, -10s, Play/Pause, +10s
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          tooltip: 'Restart',
                                          icon: const Icon(Icons.replay, color: Colors.white),
                                          onPressed: _restartVideo,
                                        ),
                                        IconButton(
                                          tooltip: 'Rewind 10s',
                                          icon: const Icon(Icons.replay_10, color: Colors.white),
                                          onPressed: _seekBackward,
                                        ),
                                        IconButton(
                                          tooltip: _videoController!.value.isPlaying ? 'Pause' : 'Play',
                                          icon: Icon(
                                            _videoController!.value.isPlaying
                                                ? Icons.pause_circle_filled
                                                : Icons.play_circle_fill,
                                            color: appcolorRed,
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _videoController!.value.isPlaying
                                                  ? _videoController!.pause()
                                                  : _videoController!.play();
                                            });
                                          },
                                        ),
                                        IconButton(
                                          tooltip: 'Forward 10s',
                                          icon: const Icon(Icons.forward_10, color: Colors.white),
                                          onPressed: _seekForward,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(
                            height: 180,
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.videocam_off_outlined,
                                    size: 40,
                                    color: Colors.grey[500],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No Video Tutorial Available',
                                    style: GoogleFonts.jost(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Benefits Section
                  workoutsection(context, Icons.info_outline, 'Benefits'),
                  const SizedBox(height: 8),
                  Text(
                    widget.work?.benifits?.isNotEmpty == true
                        ? widget.work!.benifits!
                        : 'Improves muscular strength, endurance, and overall physical posture.',
                    style: GoogleFonts.jost(
                      fontSize: screenWidth * 0.042,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // How to Do Section
                  workoutsection(context, Icons.menu_book, 'How to Do'),
                  const SizedBox(height: 8),
                  Text(
                    widget.work?.woroutSteps?.isNotEmpty == true
                        ? widget.work!.woroutSteps!
                        : '1. Maintain a strong core.\n2. Keep your back straight.\n3. Breathe steadily throughout the exercise.',
                    style: GoogleFonts.jost(
                      fontSize: screenWidth * 0.042,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Start Workout Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, anim, secAnim) => WorkoutTimer(
                              workoutName: widget.work?.workoutsName ?? 'Workout',
                              difficulty: widget.work?.difficulty ?? 'Beginner',
                              workoutDuration: widget.work?.duration,
                              workColor: appcolorRed,
                              restColor: appcolorgreen,
                              backgroundColor: appcolorwhite,
                              circularProgressSize: 250.0,
                            ),
                            transitionsBuilder: (_, anim, secAnim, child) =>
                                FadeTransition(opacity: anim, child: child),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appcolorRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        'Start Workout',
                        style: GoogleFonts.jost(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: appcolorwhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
