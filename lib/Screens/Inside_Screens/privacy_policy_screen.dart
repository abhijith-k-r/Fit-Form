import 'package:fit_form/Screens/Inside_Screens/help_screens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: settingsAppBars("Privacy Policy"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                'Fit Form respects your privacy and is committed to protecting your personal data. This Privacy Policy explains how we collect, use, and safeguard your information.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'Information We Collect',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Personal Data: Name, age, height, weight, and profile image.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Usage Data: Workouts, diet plans, and calendar events you add to the app.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'How We Use Your Data',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸To provide and personalize app features.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸To calculate fitness metrics like BMI and calories.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸To improve app functionality and user experience.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'Data Security',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                'We use industry-standard measures to protect your data. However, no method of transmission or storage is 100% secure.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'Your Rights',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Access and update your personal data.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Delete your profile and associated data at any time.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'By using FIT FORM, you agree to this Privacy Policy. For questions, contact us at [***77*****].',
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
