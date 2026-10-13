import 'package:fit_form/features/bmi/data/bmi_data_source.dart';
import 'package:fit_form/features/calendar_events/data/calendar_data_source.dart';
import 'package:fit_form/features/diet_planner/data/diet_data_source.dart';
import 'package:fit_form/features/diet_planner/data/healthy_diet_data_source.dart';
import 'package:fit_form/features/profile/data/user_data_source.dart';
import 'package:fit_form/features/workouts/data/completed_workout_data_source.dart';
import 'package:fit_form/features/workouts/data/workout_data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Single entry-point for all Hive adapter registrations and initial data loads.
/// Called once in [main()] before [runApp()].
/// Keeps [main.dart] clean — no feature-specific imports needed there.
class AppInitializer {
  AppInitializer._();

  static Future<void> init() async {
    await Hive.initFlutter();
    await UserDataSource.initialize();
    await WorkoutDataSource.initialize();
    await CalendarDataSource.initialize();
    await DietDataSource.initialize();
    await HealthyDietDataSource.initialize();
    await BmiDataSource.initialize();
    await CompletedWorkoutDataSource.initialize();
  }
}
