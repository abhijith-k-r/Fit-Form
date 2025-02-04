// !Timer_Buttons<Pause&Resart>

import 'package:flutter/material.dart';

Row pauseRestartButton(Color currentColor, bool isRunning,
    Function() pauseTimer, Function() startTimer, Function() resetTimer) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: isRunning ? pauseTimer : startTimer,
        style: ElevatedButton.styleFrom(
          backgroundColor: currentColor,
        ),
        child: Text(isRunning ? 'Pause' : 'Start'),
      ),
      const SizedBox(width: 20),
      ElevatedButton(
        onPressed: resetTimer,
        style: ElevatedButton.styleFrom(
          backgroundColor: currentColor,
        ),
        child: const Text('Reset'),
      ),
    ],
  );
}

// ! TimeCircularProgress

class TimeCircularProgress extends StatelessWidget {
  const TimeCircularProgress({
    super.key,
    required int totalSeconds,
    required int remainingSeconds,
    required this.currentColor,
  })  : _totalSeconds = totalSeconds,
        _remainingSeconds = remainingSeconds;

  final int _totalSeconds;
  final int _remainingSeconds;
  final Color currentColor;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: _totalSeconds > 0 ? 1 - (_remainingSeconds / _totalSeconds) : 0,
      strokeWidth: 10,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(currentColor),
    );
  }
}

// ! Circular_Progress_Indicator_Inside_Content<><>><

Widget insideProgressContent(
    BuildContext context,
    Color currentColor,
    String formatTime,
    int remainingSeconds,
    bool isIntervalMode,
    bool isRunning,
    bool isWorkPeriod,
    int currentRound,
    int totalRounds) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        formatTime,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: currentColor,
            ),
      ),
      if (isIntervalMode && (isRunning || remainingSeconds > 0)) ...[
        Text(
          isWorkPeriod ? 'WORK' : 'REST',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: currentColor,
              ),
        ),
        Text(
          'Round $currentRound of $totalRounds',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ],
  );
}
