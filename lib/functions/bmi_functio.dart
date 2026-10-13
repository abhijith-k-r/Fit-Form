library;

// Legacy compatibility shim.
/// BMI logic has moved to:
///   lib/features/bmi/data/bmi_data_source.dart

export 'package:fit_form/features/bmi/data/bmi_data_source.dart'
    show BmiDataSource;

import 'package:fit_form/features/bmi/data/bmi_data_source.dart';

Future<void> bmiInitialize() => BmiDataSource.initialize();
Future<void> bmicalculateInitialize() => BmiDataSource.initialize();
