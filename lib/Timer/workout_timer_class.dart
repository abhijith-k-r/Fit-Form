import 'dart:ui';

import 'package:flutter/material.dart';

class WorkoutInterval {
  final String name;
  final int minutes;
  final int seconds;
  final Color color;

  WorkoutInterval({
    required this.name,
    required this.minutes,
    required this.seconds,
    required this.color,
  });

  int get totalSeconds => (minutes * 60) + seconds;
}

