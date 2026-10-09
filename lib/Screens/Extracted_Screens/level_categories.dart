import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Padding HomeLevels(
    BuildContext context, VoidCallback onTap, String text, String assetImage) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: const EdgeInsets.fromLTRB(13, 0, 8, 15),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.9,
        height: screenWidth * 0.4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appcolorblack, appcolorRed],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
          image: DecorationImage(
            image: AssetImage(
              assetImage,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(appcolorwhite, BlendMode.dstATop),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // !><><>><
              LinearColors(appcolorwhite, appcolorRed, text, 25),
              Icon(
                Icons.timer,
                size: 40,
                shadows: [],
                color: appcolorwhite,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildWorkoutCategory(
  BuildContext context, {
  required String title,
  required String image,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      height: 150,
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        color: appcolorblack,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: GoogleFonts.fredoka(
            fontSize: 20,
            color: appcolorwhite,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}


// ! Home Carosal Itmes

final List<Map<String, dynamic>> horizontalContainerItems = [
  {
    'image': const AssetImage('asset/Work_Outs_Images/DeadLiftAi.jpg'),
    'name': 'Dead Lift',
  },
  {
    'image': const AssetImage('asset/Work_Outs_Images/LunchesAi.jpg'),
    'name': 'Lunges',
  },
  {
    'image': const AssetImage('asset/Work_Outs_Images/squatingAi.jpg'),
    'name': 'Squating',
  },
  {
    'image': const AssetImage('asset/Work_Outs_Images/PusUpAi.jpg'),
    'name': 'Push-Up ',
  },
];
