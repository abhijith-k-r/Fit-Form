// ignore_for_file: avoid_types_as_parameter_names

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/onboarding/screens/get_start_3.dart';
import 'package:fit_form/features/onboarding/screens/initial_profile_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartScreen2 extends StatelessWidget {
  const GetStartScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolorblack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'asset/Splashess_Images/SplashAi2.jpg',
                    ))),
          ),
          Positioned(
              top: 70,
              right: 10,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondAnimation) =>
                              const InitialProfileSetupScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(opacity: animation, child: child),
                        ),
                        (route) => false);
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.jost(
                        color: appcolorRed, fontWeight: FontWeight.bold),
                  ))),
          Positioned(
            top: 400,
            right: 20,
            left: 20,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ' "Transform Your Fitness, One ',
                    style: GoogleFonts.fredoka(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'Step at a Time"',
                    style: GoogleFonts.fredoka(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 50,
              right: 70,
              left: 70,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side:  BorderSide(color: appcolorRed, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context,animation,secondAnimation) => const GetStartscreen3(),transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation,child: child,),));
                  },
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                        color: appcolorwhite, fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}
