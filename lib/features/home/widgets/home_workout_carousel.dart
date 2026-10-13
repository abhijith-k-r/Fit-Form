import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/level_categories.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWorkoutCarousel extends StatelessWidget {
  const HomeWorkoutCarousel({
    super.key,
    required this.screenWidth,
    required this.isDarkMode,
  });

  final double screenWidth;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Categories',
            style: GoogleFonts.fredoka(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? appcolorwhite : appcolorblack,
            ),
          ),
        ),
        const SizedBox(height: 10),
        CarouselSlider.builder(
          itemCount: horizontalContainerItems.length,
          itemBuilder: (context, index, realIndex) {
            final adding = horizontalContainerItems[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(18),
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
                      22,
                    ),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: screenWidth * 0.4,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            viewportFraction: 0.8,
          ),
        ),
      ],
    );
  }
}
