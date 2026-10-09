// ignore_for_file: use_build_context_synchronously

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/home/screens/bottom_nave_screen.dart';
import 'package:fit_form/features/onboarding/screens/get_start_1.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNextScreen();
    super.initState();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    final db = await Hive.openBox<Usermodel>('UserBox');
    final isLog = db.values.any((e) => e.isLog == true);

    if (db.isEmpty) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondAnimation) =>
                GetStartscreen1(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ));
    } else if (isLog) {
      final data = db.values.firstWhere((element) => element.isLog == true);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondAnimation) =>
                BottomNaveScreen(
              id: data.id,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondAnimation) =>
                GetStartscreen1(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolorblack,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/Splashess_Images/Launch_Icon.png',
            width: 250,
          ),
          Image.asset(
            'asset/Splashess_Images/Fit_Form.png',
            width: 250,
          )
        ],
      )),
    );
  }
}
