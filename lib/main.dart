import 'package:fit_form/Screens/Splash_With_Get_Startss/splash_screen.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/functions/bmi_functio.dart';
import 'package:fit_form/functions/calendar_events.dart';
import 'package:fit_form/functions/diet_funtions.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UsermodelAdapter().typeId)) {
    Hive.registerAdapter(UsermodelAdapter());
  }
  await workoutInitialize();

  await calendarInitialize();

  await dietInitialize();

  await addFoodImes();

  await bmiInitialize();

  await bmicalculateInitialize();

  await healthyDietInitialize();


  runApp(const MyAPP());
}

class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDark,
      builder: (_, isDarkMOde, __) => MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: isDarkMOde ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

ValueNotifier<bool> isDark = ValueNotifier<bool>(false);
