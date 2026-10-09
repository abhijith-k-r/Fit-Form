// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fit_form/core/constants/app_keys.dart';
import 'package:fit_form/models/completed_workout_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Reactive notifier for completed workout sessions.
final ValueNotifier<List<CompletedWorkout>> completedWorkoutNotifier =
    ValueNotifier<List<CompletedWorkout>>([]);

class CompletedWorkoutDataSource {
  CompletedWorkoutDataSource._();

  static Future<Box<CompletedWorkout>> _box() =>
      Hive.openBox<CompletedWorkout>(AppKeys.completedWorkoutsBox);

  static Future<void> initialize() async {
    if (!Hive.isAdapterRegistered(CompletedWorkoutAdapter().typeId)) {
      Hive.registerAdapter(CompletedWorkoutAdapter());
    }
    await refresh();
  }

  static Future<void> refresh() async {
    final box = await _box();
    completedWorkoutNotifier.value = box.values.toList();
    completedWorkoutNotifier.notifyListeners();
  }

  static Future<void> add(CompletedWorkout workout) async {
    final box = await _box();
    workout.id = DateTime.now().microsecondsSinceEpoch.toString();
    workout.completedAt ??= DateTime.now();
    await box.put(workout.id, workout);
    await refresh();
  }

  static Future<void> delete(String id) async {
    final box = await _box();
    await box.delete(id);
    await refresh();
  }

  /// Returns workouts completed on the given calendar date (defaults to today).
  static List<CompletedWorkout> getWorkoutsForDate([DateTime? date]) {
    final target = date ?? DateTime.now();
    return completedWorkoutNotifier.value.where((w) {
      if (w.completedAt == null) return false;
      return w.completedAt!.year == target.year &&
          w.completedAt!.month == target.month &&
          w.completedAt!.day == target.day;
    }).toList();
  }

  /// Calculates counts by difficulty for today's completed workouts.
  static Map<String, int> getTodayStats() {
    final todayList = getWorkoutsForDate();
    int beginner = 0;
    int intermediate = 0;
    int advanced = 0;

    for (final w in todayList) {
      final diff = w.difficulty?.toLowerCase().trim() ?? '';
      if (diff.contains('beginner')) {
        beginner++;
      } else if (diff.contains('intermediate')) {
        intermediate++;
      } else if (diff.contains('advac') || diff.contains('advance')) {
        advanced++;
      }
    }

    return {
      'Beginner': beginner,
      'Intermediate': intermediate,
      'Advanced': advanced,
      'Total': todayList.length,
    };
  }
}
