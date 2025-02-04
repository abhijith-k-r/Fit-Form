import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Authontications_Screens/sign_in_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartscreen3 extends StatelessWidget {
  const GetStartscreen3({super.key});

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
                      'asset/Splashess_Images/splashAi3.jpg',
                    ))),
          ),
          Positioned(
            top: 490,
            right: 20,
            left: 20,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ' "Consistency is Key!"',
                    style: GoogleFonts.fredoka(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 540,
            right: 20,
            left: 20,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        '"Track your progress, stay motivated, and unlock the best version of yourself with daily challenges and reminders."',
                    style: GoogleFonts.jost(
                      fontSize: 16,
                    ),
                  ),
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
                    side: BorderSide(color: appcolorRed, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondAnimation) =>
                              const SignInUp(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ));
                  },
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                        color: appcolorwhite, fontWeight: FontWeight.bold),
                  ))),
        ],
      ),
    );
  }
}
