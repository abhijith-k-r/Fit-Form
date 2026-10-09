library;

// Legacy compatibility shim.
/// Health diet logic has moved to:
///   lib/features/diet_planner/data/healthy_diet_data_source.dart

export 'package:fit_form/features/diet_planner/data/healthy_diet_data_source.dart'
    show HealthyDietDataSource, healthyDietNotifier;

import 'package:fit_form/features/diet_planner/data/healthy_diet_data_source.dart';
import 'package:fit_form/models/healty_diet.dart';

/// Old notifier name kept for existing screens.
final healthyNotify = healthyDietNotifier;

Future<void> healthyDietInitialize() => HealthyDietDataSource.initialize();
Future<void> addHeathyDiets(HealtyDiet diet) =>
    HealthyDietDataSource.add(diet);
Future<void> getHealtyDiet() => HealthyDietDataSource.refresh();
Future<void> deletDiet(int index) => HealthyDietDataSource.deleteAt(index);
Future<void> editHealthyDiet(String id, HealtyDiet updated) =>
    HealthyDietDataSource.update(id, updated);
