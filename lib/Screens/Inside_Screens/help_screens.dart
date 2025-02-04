import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: settingsAppBars('FitForm Help Center'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the Help section of FIT FORM ! Here’s how you can make the most of our app:',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '1. Adding Workouts',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Go to the Workouts section.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Tap on the “Add Workout” button.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Fill in the details like workout name, level (Beginner, Intermediate, Advanced), image, and instructions.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Save your workout.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '2. Editing or Deleting Workouts',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Long Press on any workout to edit or delete it.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '3. Marking Favorites',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸To favorite a workout, tap the heart icon.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸View your favorite workouts in the Favorites screen.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '4. Managing Your Profile',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Navigate to the Profile section.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Add or update your image, age, height, and weight for personalized recommendations.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '5. Using the Calendar',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Go to the Calendar section.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Add events like workout schedules or meal plans.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Edit or delete events as needed.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Mark events as completed to track your progress.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '6. Diet Tracker',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Use the Diet Tracker to calculate BMI, track calories, and receive dietary recommendations.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '🔸Add healthy foods and track their calories based on weight.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '7. Workout Timer',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Start a workout to use the timer feature for time-based exercises.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                '8. Switching Themes',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                '🔸Go to Settings and toggle between Dark Mode and Light Mode to suit your preference.',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text('9. Other Settings'),
              Text(
                '🔸Access the Help, About, Privacy Policy, and Terms & Conditions sections from the Settings menu',
                style: GoogleFonts.jost(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
              ),
              Text(
                'Need Further Assistance?',
                style: GoogleFonts.fredoka(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
              ),
              Text(
                'If you have any questions or need help, please contact us at [*5477***6*].We’re here to support you on your fitness journey!',
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

AppBar settingsAppBars(String text) {
  return AppBar(
    title: Text(text, style: GoogleFonts.fredoka()),
  );
}
