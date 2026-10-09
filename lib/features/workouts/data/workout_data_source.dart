// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fit_form/core/constants/app_keys.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Reactive notifier that UI listens to.
/// Updated only by [WorkoutDataSource] — never mutated directly from widgets.
final ValueNotifier<List<WorkoutsModel>> workoutsNotifier =
    ValueNotifier<List<WorkoutsModel>>([]);

/// Single-responsibility class for all Hive CRUD on [WorkoutsModel].
/// UI files must NEVER import hive or open boxes directly.
class WorkoutDataSource {
  WorkoutDataSource._();

  static Future<Box<WorkoutsModel>> _box() =>
      Hive.openBox<WorkoutsModel>(AppKeys.workoutBox);

  /// Registers adapter and loads initial data into [workoutsNotifier].
  static Future<void> initialize() async {
    if (!Hive.isAdapterRegistered(WorkoutsModelAdapter().typeId)) {
      Hive.registerAdapter(WorkoutsModelAdapter());
    }
    await refresh();
  }

  /// Re-reads the box and pushes the full list to the notifier.
  static Future<void> refresh() async {
    final box = await _box();
    workoutsNotifier.value = box.values.toList();
    workoutsNotifier.notifyListeners();
  }

  static Future<void> add(WorkoutsModel workout) async {
    final box = await _box();
    workout.id = DateTime.now().microsecondsSinceEpoch.toString();
    await box.put(workout.id, workout);
    await refresh();
  }

  static Future<void> update(String id, WorkoutsModel workout) async {
    final box = await _box();
    workout.id = id;
    await box.put(id, workout);
    await refresh();
  }

  static Future<void> delete(String id) async {
    final box = await _box();
    await box.delete(id);
    await refresh();
  }

  static List<WorkoutsModel> filterByDifficulty(String level) =>
      workoutsNotifier.value
          .where((w) => w.difficulty?.toLowerCase() == level.toLowerCase())
          .toList();

  static List<WorkoutsModel> search(String query) =>
      workoutsNotifier.value
          .where((w) =>
              w.workoutsName?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
}
