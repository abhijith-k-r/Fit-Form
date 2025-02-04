import 'package:fit_form/Screens/Inside_Screens/help_screens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: settingsAppBars("About"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                'Welcome to Fit For your ultimate fitness companion!\n Our app is designed to help you achieve your health and fitness goals with ease and convenience.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                "Here's what you can do:",
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Workouts: Add, edit, delete, and favorite workouts for Beginner, Intermediate, and Advanced levels.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Personalized Profile: Update your profile with an image, age, height, and weight for a tailored experience.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Favorites Screen: Quickly access all your favorite workouts in one place.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Calendar & Events: Plan and track your fitness goals and meal plans, complete with a progress tracker.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Diet Tracker: Calculate BMI, track calories, and get dietary recommendations with an extensive database of healthy foods.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Workout Assistance: View workout instructions, images, and videos, and use the timer for guided sessions.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Dark & Light Mode: Switch between themes to suit your preference.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Settings: Access Help, About, Privacy Policy, and Terms & Conditions with ease.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                "At FIT FORM, we’re committed to making fitness achievable and enjoyable for everyone. Let’s get moving and stay healthy together!",
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
