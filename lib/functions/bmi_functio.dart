// ignore_for_file: unused_local_variable

import 'package:fit_form/models/bmi_calculate.dart';
import 'package:fit_form/models/bmi_calculator_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> bmiInitialize() async {
  if (!Hive.isAdapterRegistered(BmiInstructionAdapter().typeId)) {
    Hive.registerAdapter(BmiInstructionAdapter());
  }
}


Future<void> bmicalculateInitialize() async {
  if (!Hive.isAdapterRegistered(BmiCalculateAdapter().typeId)) {
    Hive.registerAdapter(BmiCalculateAdapter());
  }
}
