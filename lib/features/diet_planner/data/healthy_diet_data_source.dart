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
    bool found = false;
    for (int i = 0; i < box.length; i++) {
      final item = box.getAt(i);
      if (item?.id == id && id.isNotEmpty) {
        updated.id = id;
        await box.putAt(i, updated);
        found = true;
        break;
      }
    }
    if (!found) {
      for (int i = 0; i < box.length; i++) {
        final item = box.getAt(i);
        if (item?.healthname == updated.healthname) {
          updated.id = item?.id ?? id;
          await box.putAt(i, updated);
          found = true;
          break;
        }
      }
    }
    await refresh();
  }

  static List<HealtyDiet> getTodayMeals() {
    final now = DateTime.now();
    return healthyDietNotifier.value.where((d) {
      if (d.dateTime == null) return true;
      return d.dateTime!.year == now.year &&
          d.dateTime!.month == now.month &&
          d.dateTime!.day == now.day;
    }).toList();
  }

  static List<HealtyDiet> getTomorrowMeals() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return healthyDietNotifier.value.where((d) {
      if (d.dateTime == null) return false;
      return d.dateTime!.year == tomorrow.year &&
          d.dateTime!.month == tomorrow.month &&
          d.dateTime!.day == tomorrow.day;
    }).toList();
  }

  static List<HealtyDiet> getYesterdayMeals() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return healthyDietNotifier.value.where((d) {
      if (d.dateTime == null) return false;
      return d.dateTime!.year == yesterday.year &&
          d.dateTime!.month == yesterday.month &&
          d.dateTime!.day == yesterday.day;
    }).toList();
  }

  static double getTodayCalories() =>
      getTodayMeals().fold(0.0, (sum, d) => sum + (d.healthcalories ?? 0.0));

  static double getTomorrowCalories() =>
      getTomorrowMeals().fold(0.0, (sum, d) => sum + (d.healthcalories ?? 0.0));

  static double getYesterdayCalories() =>
      getYesterdayMeals().fold(0.0, (sum, d) => sum + (d.healthcalories ?? 0.0));
}
