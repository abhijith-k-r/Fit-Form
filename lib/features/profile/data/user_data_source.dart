// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fit_form/core/constants/app_keys.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Reactive notifier that screens listen to for user profile updates.
final ValueNotifier<List<Usermodel>> userNotifier =
    ValueNotifier<List<Usermodel>>([]);

/// Single-responsibility data source for Hive operations on [Usermodel].
class UserDataSource {
  UserDataSource._();

  static Future<Box<Usermodel>> _box() =>
      Hive.openBox<Usermodel>(AppKeys.userBox);

  static Future<void> initialize() async {
    if (!Hive.isAdapterRegistered(UsermodelAdapter().typeId)) {
      Hive.registerAdapter(UsermodelAdapter());
    }
    await refresh();
  }

  static Future<void> refresh() async {
    final box = await _box();
    userNotifier.value = box.values.toList();
    userNotifier.notifyListeners();
  }

  static Future<void> save(Usermodel user) async {
    final box = await _box();
    user.id = DateTime.now().millisecondsSinceEpoch.toString();
    await box.put(user.id, user);
    await refresh();
  }

  static Future<Usermodel?> getById(String id) async {
    final box = await _box();
    return box.get(id);
  }

  static Future<void> update(Usermodel user) async {
    final box = await _box();
    await box.put(user.id, user);
    await refresh();
  }
}
