import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Inside_Screens/healthy_edit.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthyDietShowScreen extends StatelessWidget {
  const HealthyDietShowScreen({
    super.key,
    required this.diet,
  });

  final HealtyDiet diet;

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              width: screenwidth,
              height: screenwidth * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (diet.healthimage != null &&
                          File(diet.healthimage!).existsSync())
                      ? FileImage(File(diet.healthimage!))
                      : const AssetImage(
                              'asset/Diet_Plans_Images/HealthyDiet2.jpg')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              top: 40,
              left: 10,
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                label: Text(
                  'Back',
                  style: GoogleFonts.jost(
                      color: appcolorRed,
                      fontSize: screenwidth * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                icon: Icon(Icons.arrow_back_ios_new, color: appcolorRed),
              )),
          Positioned(
              left: 0,
              top: 305,
              right: 0,
              child: Container(
                width: screenwidth * 0.8,
                height: screenwidth * 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isDark.value ? appcolorblack : appcolorwhite),
              )),
          Positioned(
            left: 20,
            top: 325,
            right: 20,
            bottom: 0,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    SizedBox(),
                    Text(
                      diet.healthname!,
                      style: GoogleFonts.jost(
                          fontSize: screenwidth * 0.07,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Calories :${diet.healthcalories.toString()}',
                          style: GoogleFonts.jost(
                              fontSize: screenwidth * 0.05,
                              fontWeight: FontWeight.w500),
                        ),
                        textButton(() {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animatin, secondaryAnimation) =>
                                        HealthyEdit(changDiets: diet),
                                transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              ));
                        }, 'Edit', EdgeInsets.zero, appcolorgreen)
                      ],
                    ),
                    Text(
                      'Description',
                      style: GoogleFonts.jost(
                          fontSize: screenwidth * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      diet.healthdescribe!,
                      style: GoogleFonts.alegreyaSansSc(
                          fontSize: screenwidth * 0.05),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
