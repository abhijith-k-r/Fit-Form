// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Timer/workout_timer_class.dart';
import 'package:fit_form/features/workouts/data/completed_workout_data_source.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/completed_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutTimer extends StatefulWidget {
  final String workoutName;
  final String difficulty;
  final String? workoutDuration;
  final Color workColor;
  final Color restColor;
  final Color backgroundColor;
  final double circularProgressSize;

  const WorkoutTimer({
    super.key,
    this.workoutName = 'Workout Session',
    this.difficulty = 'Beginner',
    this.workoutDuration,
    this.workColor = Colors.red,
    this.restColor = Colors.green,
    this.backgroundColor = Colors.white,
    this.circularProgressSize = 250.0,
  });

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer>
    with SingleTickerProviderStateMixin {
  bool _isIntervalMode = false;
  int _selectedMinutes = 0;
  int _selectedSeconds = 45;
  int _remainingSeconds = 45;
  int _totalSeconds = 45;
  int _currentRound = 0;
  final int _totalRounds = 3;
  bool _isWorkPeriod = true;
  Timer? _timer;
  bool _isRunning = false;
  bool _hasCompleted = false;
  late AnimationController _animationController;

  final WorkoutInterval _workInterval = WorkoutInterval(
    name: 'Work',
    minutes: 0,
    seconds: 30,
    color: appcolorRed,
  );
  final WorkoutInterval _restInterval = WorkoutInterval(
    name: 'Rest',
    minutes: 0,
    seconds: 15,
    color: appcolorgreen,
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Parse duration if given (e.g. "30s", "1m", "45")
    if (widget.workoutDuration != null) {
      final dur = widget.workoutDuration!.toLowerCase().trim();
      final numericOnly = int.tryParse(dur.replaceAll(RegExp(r'[^0-9]'), ''));
      if (numericOnly != null && numericOnly > 0) {
        if (dur.contains('m')) {
          _selectedMinutes = numericOnly;
          _selectedSeconds = 0;
        } else {
          _selectedMinutes = numericOnly ~/ 60;
          _selectedSeconds = numericOnly % 60;
        }
      }
    }
    _remainingSeconds = (_selectedMinutes * 60) + _selectedSeconds;
    if (_remainingSeconds <= 0) {
      _remainingSeconds = 45;
      _selectedSeconds = 45;
    }
    _totalSeconds = _remainingSeconds;
  }

  void _vibrate() async {
    try {
      await HapticFeedback.heavyImpact();
    } catch (_) {}
  }

  void startTimer() {
    if (_remainingSeconds <= 0) {
      if (_isIntervalMode) {
        _currentRound = 1;
        _isWorkPeriod = true;
        _remainingSeconds = _workInterval.totalSeconds;
        _totalSeconds = _remainingSeconds;
      } else {
        _remainingSeconds = (_selectedMinutes * 60) + _selectedSeconds;
        _totalSeconds = _remainingSeconds;
      }
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;

          if (_remainingSeconds <= 3 && _remainingSeconds > 0) {
            _vibrate();
          }

          if (_remainingSeconds == 0) {
            if (_isIntervalMode) {
              _handleIntervalTransition();
            } else {
              _timer?.cancel();
              _isRunning = false;
              _vibrate();
              _promptCompletion();
            }
          }
          _updateProgress();
        }
      });
    });

    setState(() {
      _isRunning = true;
    });
  }

  void _handleIntervalTransition() {
    _vibrate();
    if (_isWorkPeriod) {
      if (_currentRound < _totalRounds) {
        _isWorkPeriod = false;
        _remainingSeconds = _restInterval.totalSeconds;
        _totalSeconds = _remainingSeconds;
      } else {
        _timer?.cancel();
        _isRunning = false;
        _promptCompletion();
      }
    } else {
      _currentRound++;
      _isWorkPeriod = true;
      _remainingSeconds = _workInterval.totalSeconds;
      _totalSeconds = _remainingSeconds;
    }
  }

  void _updateProgress() {
    if (_totalSeconds > 0) {
      double progress = _remainingSeconds / _totalSeconds;
      _animationController.value = 1.0 - progress;
    }
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isWorkPeriod = true;
      _animationController.value = 0;
      if (_isIntervalMode) {
        _currentRound = 0;
        _remainingSeconds = _workInterval.totalSeconds;
        _totalSeconds = _remainingSeconds;
      } else {
        _remainingSeconds = (_selectedMinutes * 60) + _selectedSeconds;
        _totalSeconds = _remainingSeconds;
      }
    });
  }

  String formatTime(int totalSecs) {
    int minutes = totalSecs ~/ 60;
    int seconds = totalSecs % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _recordWorkoutCompletion() async {
    if (_hasCompleted) return;
    _hasCompleted = true;

    final session = CompletedWorkout(
      workoutName: widget.workoutName,
      difficulty: widget.difficulty,
      completedAt: DateTime.now(),
      durationSeconds: _totalSeconds - _remainingSeconds > 0
          ? _totalSeconds - _remainingSeconds
          : _totalSeconds,
    );

    await CompletedWorkoutDataSource.add(session);
  }

  void _promptCompletion() async {
    await _recordWorkoutCompletion();

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.green, size: 64),
            const SizedBox(height: 12),
            Text(
              'Workout Completed! 🎉',
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Great job finishing "${widget.workoutName}"!',
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: appcolorRed.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Level: ${widget.difficulty}',
                style: GoogleFonts.jost(
                  color: appcolorRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appcolorRed,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(ctx); // Close dialog
                Navigator.pop(context); // Return to workouts
              },
              child: Text(
                'Done & Back to Home',
                style: GoogleFonts.jost(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = isDark.value;
    final Color currentColor = _isIntervalMode
        ? (_isWorkPeriod ? widget.workColor : widget.restColor)
        : widget.workColor;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: isDarkMode ? appcolorwhite : appcolorblack),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              widget.workoutName,
              style: GoogleFonts.jost(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
            Text(
              widget.difficulty,
              style: GoogleFonts.jost(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: appcolorRed,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Interval vs Single mode switch
              if (!_isRunning)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromARGB(255, 34, 34, 34)
                        : const Color.fromARGB(255, 245, 245, 247),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isIntervalMode ? 'Interval Workout' : 'Standard Timer',
                        style: GoogleFonts.jost(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? appcolorwhite : appcolorblack,
                        ),
                      ),
                      Switch(
                        activeThumbColor: appcolorRed,
                        value: _isIntervalMode,
                        onChanged: (val) {
                          setState(() {
                            _isIntervalMode = val;
                            resetTimer();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),

              // Time Adjusters if not running
              if (!_isRunning && !_isIntervalMode) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimePickerColumn(
                      label: 'Minutes',
                      value: _selectedMinutes,
                      max: 60,
                      onChanged: (val) {
                        setState(() {
                          _selectedMinutes = val;
                          _remainingSeconds =
                              (_selectedMinutes * 60) + _selectedSeconds;
                          _totalSeconds = _remainingSeconds;
                        });
                      },
                      isDark: isDarkMode,
                    ),
                    const SizedBox(width: 20),
                    _buildTimePickerColumn(
                      label: 'Seconds',
                      value: _selectedSeconds,
                      max: 59,
                      onChanged: (val) {
                        setState(() {
                          _selectedSeconds = val;
                          _remainingSeconds =
                              (_selectedMinutes * 60) + _selectedSeconds;
                          _totalSeconds = _remainingSeconds;
                        });
                      },
                      isDark: isDarkMode,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // Circular Progress Timer
              SizedBox(
                width: widget.circularProgressSize,
                height: widget.circularProgressSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: widget.circularProgressSize,
                      height: widget.circularProgressSize,
                      child: CircularProgressIndicator(
                        value: _totalSeconds > 0
                            ? 1 - (_remainingSeconds / _totalSeconds)
                            : 0,
                        strokeWidth: 12,
                        backgroundColor: isDarkMode
                            ? const Color.fromARGB(255, 45, 45, 45)
                            : Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(currentColor),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formatTime(_remainingSeconds),
                          style: GoogleFonts.jost(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? appcolorwhite : appcolorblack,
                          ),
                        ),
                        if (_isIntervalMode) ...[
                          Text(
                            _isWorkPeriod ? 'WORK PERIOD' : 'REST PERIOD',
                            style: GoogleFonts.jost(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: currentColor,
                            ),
                          ),
                          Text(
                            'Round $_currentRound of $_totalRounds',
                            style: GoogleFonts.jost(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Control buttons: Start/Pause and Reset
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isRunning ? pauseTimer : startTimer,
                    icon: Icon(
                      _isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    label: Text(
                      _isRunning ? 'Pause' : 'Start',
                      style: GoogleFonts.jost(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: resetTimer,
                    icon: Icon(Icons.refresh,
                        color: isDarkMode ? appcolorwhite : appcolorblack),
                    label: Text(
                      'Reset',
                      style: GoogleFonts.jost(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? appcolorwhite : appcolorblack,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Complete Workout Button
              SizedBox(
                width: screenWidth * 0.75,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _timer?.cancel();
                    _isRunning = false;
                    _promptCompletion();
                  },
                  icon: const Icon(Icons.task_alt, color: Colors.white),
                  label: Text(
                    'Mark as Completed',
                    style: GoogleFonts.jost(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePickerColumn({
    required String label,
    required int value,
    required int max,
    required ValueChanged<int> onChanged,
    required bool isDark,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.jost(
            fontSize: 13,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isDark
                ? const Color.fromARGB(255, 34, 34, 34)
                : const Color.fromARGB(255, 240, 240, 242),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<int>(
            value: value,
            underline: const SizedBox(),
            dropdownColor: isDark
                ? const Color.fromARGB(255, 40, 40, 40)
                : Colors.white,
            items: List.generate(max + 1, (index) {
              return DropdownMenuItem(
                value: index,
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? appcolorwhite : appcolorblack,
                  ),
                ),
              );
            }),
            onChanged: (val) {
              if (val != null) onChanged(val);
            },
          ),
        ),
      ],
    );
  }
}
