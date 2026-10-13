import 'package:fit_form/core/constants/app_keys.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:fit_form/models/bmi_calculator_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Hive initializer and CRUD for BMI-related boxes.
/// All box access is centralised here — UI never imports hive.
class BmiDataSource {
  BmiDataSource._();

  static Future<void> initialize() async {
    if (!Hive.isAdapterRegistered(BmiInstructionAdapter().typeId)) {
      Hive.registerAdapter(BmiInstructionAdapter());
    }
    if (!Hive.isAdapterRegistered(BmiCalculateAdapter().typeId)) {
      Hive.registerAdapter(BmiCalculateAdapter());
    }
  }

  // ── BmiInstruction (category guidance) ───────────────────────────────

  static Future<Box<BmiInstruction>> _instructionBox() =>
      Hive.openBox<BmiInstruction>(AppKeys.bmiInstructionBox);

  static Future<List<BmiInstruction>> getAllInstructions() async {
    final box = await _instructionBox();
    return box.values.toList();
  }

  static Future<void> addInstruction(BmiInstruction instruction) async {
    final box = await _instructionBox();
    instruction.id = DateTime.now().microsecondsSinceEpoch.toString();
    await box.put(instruction.id, instruction);
  }

  static Future<void> deleteInstruction(String id) async {
    final box = await _instructionBox();
    await box.delete(id);
  }

  // ── BmiCalculate (user BMI log entries) ──────────────────────────────

  static Future<Box<BmiCalculate>> _calculateBox() =>
      Hive.openBox<BmiCalculate>(AppKeys.bmiCalculateBox);

  static Future<List<BmiCalculate>> getAllCalculations() async {
    final box = await _calculateBox();
    return box.values.toList();
  }

  static Future<void> saveCalculation(BmiCalculate entry) async {
    final box = await _calculateBox();
    entry.id = DateTime.now().microsecondsSinceEpoch.toString();
    await box.put(entry.id, entry);
  }

  static Future<void> deleteCalculation(String id) async {
    final box = await _calculateBox();
    await box.delete(id);
  }
}
