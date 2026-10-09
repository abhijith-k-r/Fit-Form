/// All Hive box names and storage keys in one place.
/// Never hard-code box name strings in UI or repository files.
class AppKeys {
  AppKeys._();

  // ── Hive Box Names ────────────────────────────────────────────────────
  static const String userBox = 'UserBox';
  static const String workoutBox = 'WorkoutBox';
  static const String eventBox = 'EventBox';
  static const String foodItemsBox = 'foodItems';
  static const String healthyDietsBox = 'HealtyDiets';
  static const String bmiInstructionBox = 'BmiInstructionBox';
  static const String bmiCalculateBox = 'BmiCalculateBox';
  static const String completedWorkoutsBox = 'completedWorkouts';

  // ── SharedPreferences / Misc Keys ────────────────────────────────────
  static const String currentUserId = 'current_user_id';
}
