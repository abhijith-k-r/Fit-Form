import 'package:fit_form/Screens/Inside_Screens/help_screens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: settingsAppBars('Terms & Conditions'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                'Thank you for using FitForm! By accessing the app, you agree to the following terms:',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'Usage Guidelines',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸You are responsible for the accuracy of the information you provide (e.g., age, height, weight).',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Do not misuse the app’s features or provide inappropriate content.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'Health Disclaimer',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Consult a medical professional before starting any fitness or diet plan.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸The app’s calculations and recommendations are for informational purposes only and not a substitute for professional advice.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'Limitation of Liability',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                'FitForm  is not responsible for injuries, damages, or losses resulting from the use of this app.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'Termination',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                'We reserve the right to terminate access if these terms are violated.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'Changes to Terms',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                'We may update these terms at any time. Continued use of the app constitutes acceptance of any changes.',
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
