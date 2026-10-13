import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class WorkoutMxPlayer extends StatefulWidget {
  const WorkoutMxPlayer({
    super.key,
    required this.videoPath,
    required this.isDarkMode,
  });

  final String? videoPath;
  final bool isDarkMode;

  @override
  State<WorkoutMxPlayer> createState() => _WorkoutMxPlayerState();
}

class _WorkoutMxPlayerState extends State<WorkoutMxPlayer> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // MX Player gesture scrubbing
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
    final path = widget.videoPath;
    if (path != null && path.isNotEmpty && File(path).existsSync()) {
      _videoController = VideoPlayerController.file(File(path))
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
          debugPrint('Video error: $e');
        });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final m = twoDigits(duration.inMinutes.remainder(60));
    final s = twoDigits(duration.inSeconds.remainder(60));
    return '$m:$s';
  }

  void _seekDelta(int seconds) {
    if (_videoController == null) return;
    final target = _currentPosition + Duration(seconds: seconds);
    final clamped = target < Duration.zero
        ? Duration.zero
        : (target > _totalDuration ? _totalDuration : target);
    _videoController!.seekTo(clamped);
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVideoInitialized || _videoController == null) {
      return Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.isDarkMode
              ? const Color.fromARGB(255, 24, 24, 24)
              : Colors.grey[900],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.videocam_off_outlined,
                  size: 38, color: Colors.grey[500]),
              const SizedBox(height: 8),
              Text(
                'No Video Tutorial Available',
                style: GoogleFonts.jost(color: Colors.grey[400], fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: widget.isDarkMode
            ? const Color.fromARGB(255, 24, 24, 24)
            : Colors.grey[900],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Gesture Surface with MX Player HUD
          GestureDetector(
            onHorizontalDragStart: (details) {
              setState(() {
                _isDragging = true;
                _dragStartPosition = _currentPosition;
                _dragTargetPosition = _currentPosition;
                _dragAccumulatedDx = 0;
              });
            },
            onHorizontalDragUpdate: (details) {
              setState(() {
                _dragAccumulatedDx += details.primaryDelta ?? 0;
                final offsetMs = (_dragAccumulatedDx * 80).toInt();
                final newPos =
                    _dragStartPosition + Duration(milliseconds: offsetMs);
                _dragTargetPosition = newPos < Duration.zero
                    ? Duration.zero
                    : (newPos > _totalDuration ? _totalDuration : newPos);
              });
            },
            onHorizontalDragEnd: (details) {
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
                if (_isDragging)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
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
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!_videoController!.value.isPlaying && !_isDragging)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded,
                        color: Colors.white, size: 44),
                  ),
              ],
            ),
          ),

          // Control Bar
          Container(
            color: Colors.black.withValues(alpha: 0.85),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(_formatDuration(_currentPosition),
                        style: GoogleFonts.jost(
                            color: Colors.white70, fontSize: 12)),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: appcolorRed,
                          inactiveTrackColor: Colors.white24,
                          thumbColor: appcolorRed,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6),
                          trackHeight: 3,
                        ),
                        child: Slider(
                          value: _currentPosition.inMilliseconds
                              .toDouble()
                              .clamp(
                                  0.0, _totalDuration.inMilliseconds.toDouble()),
                          min: 0.0,
                          max: _totalDuration.inMilliseconds > 0
                              ? _totalDuration.inMilliseconds.toDouble()
                              : 1.0,
                          onChanged: (val) {
                            _videoController!
                                .seekTo(Duration(milliseconds: val.toInt()));
                          },
                        ),
                      ),
                    ),
                    Text(_formatDuration(_totalDuration),
                        style: GoogleFonts.jost(
                            color: Colors.white70, fontSize: 12)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      tooltip: 'Restart',
                      icon: const Icon(Icons.replay, color: Colors.white),
                      onPressed: () {
                        _videoController!.seekTo(Duration.zero);
                        _videoController!.play();
                      },
                    ),
                    IconButton(
                      tooltip: 'Rewind 10s',
                      icon: const Icon(Icons.replay_10, color: Colors.white),
                      onPressed: () => _seekDelta(-10),
                    ),
                    IconButton(
                      icon: Icon(
                        _videoController!.value.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: appcolorRed,
                        size: 38,
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
                      onPressed: () => _seekDelta(10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
