library;

// Legacy compatibility shim.
/// All workout logic has moved to:
///   lib/features/workouts/data/workout_data_source.dart
///
/// This file re-exports the notifier and delegates all calls so that
/// existing screen imports continue to work without any changes.

export 'package:fit_form/features/workouts/data/workout_data_source.dart'
    show WorkoutDataSource, workoutsNotifier;

// ── Legacy aliases (keep old call-sites compiling) ────────────────────

import 'package:fit_form/features/workouts/data/workout_data_source.dart';
import 'package:fit_form/models/workouts_model.dart';

/// Old global notifier name kept for backward compatibility.
final workoutsNotify = workoutsNotifier;

Future<void> workoutInitialize() => WorkoutDataSource.initialize();
Future<void> addWorkout(WorkoutsModel w) => WorkoutDataSource.add(w);
Future<void> getWorkouts() => WorkoutDataSource.refresh();
Future<void> deleteWorkout(String id) => WorkoutDataSource.delete(id);
Future<void> editWorkout(String id, WorkoutsModel w) =>
    WorkoutDataSource.update(id, w);
List<WorkoutsModel> getWorkoutsByDifficulty(String level) =>
    WorkoutDataSource.filterByDifficulty(level);
List<WorkoutsModel> searchWorkouts(String q) => WorkoutDataSource.search(q);
