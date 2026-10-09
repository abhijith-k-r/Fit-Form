// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fit_form/core/constants/app_keys.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Reactive notifier for user's custom healthy diet entries.
final ValueNotifier<List<HealtyDiet>> healthyDietNotifier =
    ValueNotifier<List<HealtyDiet>>([]);

/// Hive CRUD for [HealtyDiet] — UI must never touch the box directly.
class HealthyDietDataSource {
  HealthyDietDataSource._();

  static Future<Box<HealtyDiet>> _box() =>
      Hive.openBox<HealtyDiet>(AppKeys.healthyDietsBox);

  static Future<void> initialize() async {
    if (!Hive.isAdapterRegistered(HealtyDietAdapter().typeId)) {
      Hive.registerAdapter(HealtyDietAdapter());
    }
    await refresh();
  }

  static Future<void> refresh() async {
    final box = await _box();
    healthyDietNotifier.value = box.values.toList();
    healthyDietNotifier.notifyListeners();
  }

  static Future<void> add(HealtyDiet diet) async {
    final box = await _box();
    diet.id = DateTime.now().microsecondsSinceEpoch.toString();
    await box.add(diet);
    await refresh();
  }

  static Future<void> deleteAt(int index) async {
    final box = await _box();
    await box.deleteAt(index);
    await refresh();
  }

  static Future<void> update(String id, HealtyDiet updated) async {
    final box = await _box();
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)?.id == id) {
        await box.putAt(i, updated);
        break;
      }
    }
    await refresh();
  }
}
