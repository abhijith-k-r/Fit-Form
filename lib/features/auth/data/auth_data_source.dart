// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:fit_form/core/constants/app_keys.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Reactive notifier that screens listen to for user list updates.
final ValueNotifier<List<Usermodel>> userNotifier =
    ValueNotifier<List<Usermodel>>([]);

/// Single-responsibility class for all Hive CRUD on [Usermodel].
/// Navigation and UI responses belong in the calling widget, NOT here.
class AuthDataSource {
  AuthDataSource._();

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

  static Future<void> signUp(Usermodel user) async {
    final box = await _box();
    user.id = DateTime.now().millisecondsSinceEpoch.toString();
    await box.put(user.id, user);
    await refresh();
  }

  /// Returns matched [Usermodel] on success, null on failure.
  /// Caller is responsible for navigation and showing UI feedback.
  static Future<Usermodel?> signIn(String email, String password) async {
    final box = await _box();
    try {
      final user = box.values.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      user.isLog = true;
      await box.put(user.id, user);
      await refresh();
      return user;
    } catch (_) {
      return null;
    }
  }

  static Future<void> logOut(String id) async {
    final box = await _box();
    final user = box.get(id);
    if (user != null) {
      user.isLog = false;
      await box.put(id, user);
      await refresh();
    }
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

  /// Returns the first logged-in user, or null if none.
  static Future<Usermodel?> getLoggedInUser() async {
    final box = await _box();
    try {
      return box.values.firstWhere((u) => u.isLog == true);
    } catch (_) {
      return null;
    }
  }
}
