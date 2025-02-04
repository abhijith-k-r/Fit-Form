// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<WorkoutsModel>> workoutsNotify = ValueNotifier([]);

Future<void> workoutInitialize() async {
  if (!Hive.isAdapterRegistered(WorkoutsModelAdapter().typeId)) {
    Hive.registerAdapter(WorkoutsModelAdapter());
  }
  await getWorkouts();
}

Future<void> addWorkout(WorkoutsModel workout) async {
  final data = await Hive.openBox<WorkoutsModel>('WorkoutBox');
  String customId = DateTime.now().microsecondsSinceEpoch.toString();
  workout.id = customId;
  if (workout.workoutsImage != null) {
    await data.put(workout.id, workout);
  } else {
    await data.put(workout.id, workout);
  }
}

Future<void> getWorkouts() async {
  final data = await Hive.openBox<WorkoutsModel>('WorkoutBox');
  workoutsNotify.value.clear();
  workoutsNotify.value.addAll(data.values);
  workoutsNotify.notifyListeners();
}

List<WorkoutsModel> getWorkoutsByDifficulty(String level) {
  return workoutsNotify.value.where((workout) {
    return workout.difficulty?.toLowerCase() == level.toLowerCase();
  }).toList();
}

Future<void> deleteWorkout(String id) async {
  final data = await Hive.openBox<WorkoutsModel>('WorkoutBox');
  await data.delete(id);
  await getWorkouts();
}

Future<void> editWorkout(String id, WorkoutsModel updatedWorkout) async {
  final data = await Hive.openBox<WorkoutsModel>('WorkoutBox');
  updatedWorkout.id = id;
  await data.put(id, updatedWorkout);
  await getWorkouts();
}

List<WorkoutsModel> searchWorkouts(String query) {
  return workoutsNotify.value.where((workout) {
    return workout.workoutsName!.toLowerCase().contains(query.toLowerCase());
  }).toList();
}
