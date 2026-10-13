library;

// Compatibility shim for user profile data.
/// Profile storage logic is in:
///   lib/features/profile/data/user_data_source.dart

export 'package:fit_form/features/profile/data/user_data_source.dart'
    show UserDataSource, userNotifier;

import 'package:fit_form/features/profile/data/user_data_source.dart';
import 'package:fit_form/models/usermodel.dart';

/// Legacy notifier alias kept for compatibility.
final userDatas = userNotifier;

Future<void> hiveInitialize() => UserDataSource.initialize();
Future<void> addSignUp(Usermodel user) => UserDataSource.save(user);
Future<void> getData() => UserDataSource.refresh();
