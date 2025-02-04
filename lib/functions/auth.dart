import 'package:fit_form/Screens/Authontications_Screens/sign_in_up.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/bottom_nave_screen.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> hiveInitialize() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UsermodelAdapter().typeId)) {
    Hive.registerAdapter(UsermodelAdapter());
  }
}

Future<void> addSignUp(Usermodel data) async {
  final db = await Hive.openBox<Usermodel>('UserBox');
  String customId = DateTime.now().millisecondsSinceEpoch.toString();
  data.id = customId;
  db.put(data.id, data);
}

Future<void> addsignIn(
    String email, String password, BuildContext context) async {
  final db = await Hive.openBox<Usermodel>('UserBox');

  try {
    final model =
        db.values.firstWhere((e) => e.email == email && e.password == password);
    model.isLog == true;
    db.put(model.id, model);
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (_) => BottomNaveScreen(
                  id: model.id!,
                )));
  } catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Invalid email or password.',
          selectionColor: Colors.white,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

Future<void> logOut(String id, BuildContext context) async {
  final db = await Hive.openBox<Usermodel>('UserBox');

  final model = db.get(id);
  if (model != null) {
    model.isLog = false;

    await db.put(id, model);

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => SignInUp()), (route) => false);
  } else {}
}


ValueNotifier<List<Usermodel>> userDatas = ValueNotifier([]);

Future<void> getData() async {
  final db = await Hive.openBox<Usermodel>('UserBox');
  userDatas.value.clear();
  userDatas.value.addAll(db.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  userDatas.notifyListeners();
}




// ValueNotifier<Usermodel?> currentUserNotifier = ValueNotifier<Usermodel?>(null);

// Future<void> fetchUserData(String id) async {
//   final db = await Hive.openBox<Usermodel>('UserBox');
//   final fetchedUser = db.get(id);
//   currentUserNotifier.value = fetchedUser;
//   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//   currentUserNotifier.notifyListeners();
// }




