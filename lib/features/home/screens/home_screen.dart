import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/homescreen_profile.dart';
import 'package:fit_form/Screens/Extracted_Screens/addworkout_functions.dart';
import 'package:fit_form/Screens/Extracted_Screens/level_categories.dart';
import 'package:fit_form/Screens/Inside_Screens/advaced_levels.dart';
import 'package:fit_form/Screens/Inside_Screens/beginner_levels.dart';
import 'package:fit_form/Screens/Inside_Screens/intermediate_levels.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.id,
  });

  final String? id;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
        valueListenable: userDatas,
        builder: (context, user, child) {
          if (user.isEmpty) {
            return const CircularProgressIndicator();
          }
          final home = user.firstWhere((elements) => elements.id == widget.id);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Hello ${home.fullName} !',
                style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                        // color: appcolorRed,
                        fontWeight: FontWeight.w600,
                        fontSize: 24)),
              ),
              actions: [
                InkWell(
                  onTap: () => show_HomeScree_Popup_Profile(context, home.id),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: appcolorRed,
                    backgroundImage: home.imagePath != null
                        ? FileImage(File(home.imagePath!))
                        : null,
                    child: home.imagePath == null
                        ? Icon(
                            Icons.person_pin,
                            color: appcolorwhite,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'FitForm is your ultimate home fitness \ncompanion for a healthier lifestyle.',
                    style: GoogleFonts.jost(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                  ListTile(
                    title: Text(
                      'Categories',
                      style: GoogleFonts.fredoka(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Column(children: [
                    CarouselSlider.builder(
                        itemCount: horizontalContainerItems.length,
                        itemBuilder: (context, index, realIndex) {
                          final adding = horizontalContainerItems[index];
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                  width: screenWidth * 0.8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: adding['image'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: LinearColors(
                                              appcoloryellow,
                                              appcolorRed,
                                              adding['name'],
                                              22)))));
                        },
                        options: CarouselOptions(
                            height: screenWidth * 0.4,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            viewportFraction: 0.8))
                  ]),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 15),
                      child: workoutsection(
                          context, Icons.sports_handball_sharp, 'Trainings')),
                  HomeLevels(
                      context,
                      () => Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      BeginnerLevels(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  FadeTransition(
                                      opacity: animation, child: child))),
                      'Beginner',
                      'asset/Work_Outs_Images/beginnerNew.jpg'),
                  HomeLevels(
                      context,
                      () => Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      IntermediateLevels(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  FadeTransition(
                                      opacity: animation, child: child))),
                      'Intermediate',
                      'asset/Work_Outs_Images/intermediatNewone.jpg'),
                  HomeLevels(
                      context,
                      () => Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      AdvancedLevels(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  FadeTransition(
                                      opacity: animation, child: child))),
                      'Advaced',
                      'asset/Work_Outs_Images/AdvancedAi.webp'),
                ],
              ),
            ),
          );
        });
  }
}


