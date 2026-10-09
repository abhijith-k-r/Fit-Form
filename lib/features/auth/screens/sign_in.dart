import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/auth/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('asset/Splashess_Images/Loging_Image.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 33,
            child: Text(
              'Hello \nSign In',
              style: GoogleFonts.fredoka(
                fontSize: 32,
                color: appcolorwhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: Center(
              child: SingleChildScrollView(
                child: SignInForm(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
