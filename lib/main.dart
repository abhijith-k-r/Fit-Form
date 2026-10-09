import 'package:fit_form/core/services/app_initializer.dart';
import 'package:fit_form/features/onboarding/screens/splash_screen.dart';
import 'package:flutter/material.dart';

/// Global dark-mode notifier — kept here so MaterialApp can access it.
/// In a future refactor this can move to a ThemeDataSource.
ValueNotifier<bool> isDark = ValueNotifier<bool>(false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  runApp(const FitFormApp());
}

class FitFormApp extends StatelessWidget {
  const FitFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (_, isDarkMode, __) => MaterialApp(
        title: 'Fit Form',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: SplashScreen(),
      ),
    );
  }
}
