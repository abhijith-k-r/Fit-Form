import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/Screens/Extracted_Screens/level_categories.dart';
import 'package:fit_form/Screens/Inside_Screens/advaced_levels.dart';
import 'package:fit_form/Screens/Inside_Screens/beginner_levels.dart';
import 'package:fit_form/Screens/Inside_Screens/intermediate_levels.dart';
import 'package:flutter/material.dart';

class HomeLevelCategoriesSection extends StatelessWidget {
  const HomeLevelCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 26, 20, 12),
          child: workoutsection(
            context,
            Icons.sports_handball_sharp,
            'Trainings',
          ),
        ),
        HomeLevels(
          context,
          () => _navigate(context, const BeginnerLevels()),
          'Beginner',
          'asset/Work_Outs_Images/beginnerNew.jpg',
        ),
        const SizedBox(height: 10),
        HomeLevels(
          context,
          () => _navigate(context, const IntermediateLevels()),
          'Intermediate',
          'asset/Work_Outs_Images/intermediatNewone.jpg',
        ),
        const SizedBox(height: 10),
        HomeLevels(
          context,
          () => _navigate(context, const AdvancedLevels()),
          'Advaced',
          'asset/Work_Outs_Images/AdvancedAi.webp',
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }
}
