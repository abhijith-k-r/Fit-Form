library;

// Legacy compatibility shim.
/// Auth logic has moved to:
///   lib/features/auth/data/auth_data_source.dart
///
/// Navigation is now the CALLER's responsibility.
/// Screens calling addsignIn must handle navigation themselves.

export 'package:fit_form/features/auth/data/auth_data_source.dart'
    show AuthDataSource, userNotifier;

import 'package:fit_form/features/auth/data/auth_data_source.dart';
import 'package:fit_form/models/usermodel.dart';

/// Old notifier name kept for compatibility.
final userDatas = userNotifier;

Future<void> hiveInitialize() => AuthDataSource.initialize();
Future<void> addSignUp(Usermodel user) => AuthDataSource.signUp(user);
Future<void> getData() => AuthDataSource.refresh();
Future<void> logOut(String id) => AuthDataSource.logOut(id);

/// NOTE: This no longer accepts [BuildContext].
/// Callers must handle navigation after checking the return value.
Future<Usermodel?> addsignIn(String email, String password) =>
    AuthDataSource.signIn(email, password);
