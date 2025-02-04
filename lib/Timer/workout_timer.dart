import 'dart:async';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Timer/workout_timer_functions.dart';
import 'package:fit_form/Timer/workout_timer_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutTimer extends StatefulWidget {
  final Color workColor;
  final Color restColor;
  final Color backgroundColor;
  final double circularProgressSize;

  const WorkoutTimer({
    super.key,
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
  // Timer settings
  bool _isIntervalMode = false;
  int _selectedMinutes = 0;
  int _selectedSeconds = 0;
  int _remainingSeconds = 0;
  int _totalSeconds = 0;
  int _currentRound = 0;
  int _totalRounds = 1;
  bool _isWorkPeriod = true;
  Timer? _timer;
  bool _isRunning = false;
  late AnimationController _animationController;

  // Interval settings
  WorkoutInterval _workInterval = WorkoutInterval(
    name: 'Work',
    minutes: 0,
    seconds: 30,
    color: appcolorblue,
  );
  WorkoutInterval _restInterval = WorkoutInterval(
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
  }

  void _vibrate() async {
    await HapticFeedback.heavyImpact();
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

          // Vibrate for last 3 seconds
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
        resetTimer();
      }
    } else {
      _currentRound++;
      _isWorkPeriod = true;
      _remainingSeconds = _workInterval.totalSeconds;
      _totalSeconds = _remainingSeconds;
    }
  }

  void _updateProgress() {
    double progress = _remainingSeconds / _totalSeconds;
    _animationController.value = 1.0 - progress;
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
      _remainingSeconds = 0;
      _totalSeconds = 0;
      _currentRound = 0;
      _isRunning = false;
      _isWorkPeriod = true;
      _animationController.value = 0;
    });
  }

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color currentColor = _isIntervalMode
        ? (_isWorkPeriod ? widget.workColor : widget.restColor)
        : widget.workColor;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_isRunning && _remainingSeconds == 0) ...[
                Switch(
                  activeColor: appcolorRed,
                  value: _isIntervalMode,
                  onChanged: (value) {
                    setState(() {
                      _isIntervalMode = value;
                      resetTimer();
                    });
                  },
                ),
                Text(
                  _isIntervalMode ? 'Interval Timer' : 'Single Timer',
                  style: GoogleFonts.jost(fontSize: screenWidth * 0.04),
                ),
              ],

              // Timer Settings
              if (!_isRunning && _remainingSeconds == 0) ...[
                if (_isIntervalMode) ...[
                  // Interval Settings
                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Work Time (sec)',
                            style:
                                GoogleFonts.jost(fontSize: screenWidth * 0.04),
                          ),
                          SizedBox(
                            width: screenWidth * 0.3,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _workInterval = WorkoutInterval(
                                    name: 'Work',
                                    minutes: 0,
                                    seconds: int.tryParse(value) ?? 30,
                                    color: widget.workColor,
                                  );
                                });
                              },
                              controller: TextEditingController(
                                  text: _workInterval.seconds.toString()),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Rest Time (sec)',
                            style:
                                GoogleFonts.jost(fontSize: screenWidth * 0.04),
                          ),
                          SizedBox(
                            width: screenWidth * 0.3,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _restInterval = WorkoutInterval(
                                    name: 'Rest',
                                    minutes: 0,
                                    seconds: int.tryParse(value) ?? 15,
                                    color: widget.restColor,
                                  );
                                });
                              },
                              controller: TextEditingController(
                                  text: _restInterval.seconds.toString()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Rounds: ',
                            style:
                                GoogleFonts.jost(fontSize: screenWidth * 0.04),
                          ),
                          SizedBox(
                            width: screenWidth * 0.4,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _totalRounds = int.tryParse(value) ?? 1;
                                });
                              },
                              controller: TextEditingController(
                                  text: _totalRounds.toString()),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ] else ...[
                  //! Single Timer Settings

                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Minutes',
                            style:
                                GoogleFonts.jost(fontSize: screenWidth * 0.04),
                          ),
                          SizedBox(
                            width: 70,
                            child: DropdownButton<int>(
                              value: _selectedMinutes,
                              items: List.generate(60, (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(index.toString()),
                                );
                              }),
                              onChanged: (value) {
                                setState(() {
                                  _selectedMinutes = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Seconds',
                            style:
                                GoogleFonts.jost(fontSize: screenWidth * 0.04),
                          ),
                          SizedBox(
                            width: 70,
                            child: DropdownButton<int>(
                              value: _selectedSeconds,
                              items: List.generate(60, (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Text(index.toString()),
                                );
                              }),
                              onChanged: (value) {
                                setState(() {
                                  _selectedSeconds = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ],

              //! Circular Progress and Timer Display
              Stack(alignment: Alignment.center, children: [
                SizedBox(
                  width: widget.circularProgressSize,
                  height: widget.circularProgressSize,
                  child: TimeCircularProgress(
                      totalSeconds: _totalSeconds,
                      remainingSeconds: _remainingSeconds,
                      currentColor: currentColor),
                ),
                insideProgressContent(
                    context,
                    currentColor,
                    formatTime(_remainingSeconds),
                    _remainingSeconds,
                    _isIntervalMode,
                    _isRunning,
                    _isWorkPeriod,
                    _currentRound,
                    _totalRounds)
              ]),
              pauseRestartButton(currentColor, _isRunning, () => pauseTimer(),
                  () => startTimer(), () => resetTimer()),
            ],
          ),
        ),
      ),
    );
  }
}
