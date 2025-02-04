import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/delet_funcion.dart';
import 'package:fit_form/Screens/Inside_Screens/healthy_show.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthyFavorite extends StatelessWidget {
  const HealthyFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dietes Favorites',
          style: GoogleFonts.jost(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: healthyNotify,
        builder: (context, List<HealtyDiet> diets, child) {
          List<HealtyDiet> favoriteDiets =
              diets.where((Dite) => Dite.favorite == true).toList();

          return favoriteDiets.isEmpty
              ? Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [appcolorpink, appcoloryellow],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'No favorite Healthy Diets yet.',
                      style: GoogleFonts.jost(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: appcolorwhite),
                    ),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemCount: favoriteDiets.length,
                  itemBuilder: (context, index) {
                    final Diete = favoriteDiets[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    HealthyDietShowScreen(
                              diet: Diete,
                            ),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          )),
                      child: Card(
                          child: Column(children: [
                        Container(
                            width: screenWidth,
                            height: screenWidth * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                image: (Diete.healthimage != null &&
                                        File(Diete.healthimage!).existsSync())
                                    ? DecorationImage(
                                        image:
                                            FileImage(File(Diete.healthimage!)),
                                        fit: BoxFit.fill)
                                    : null),
                            child: (Diete.healthimage == null ||
                                    !File(Diete.healthimage!).existsSync())
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.asset(
                                        'asset/Work_Outs_Images/BeginnerAi.webp',
                                        fit: BoxFit.cover))
                                : null),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(Diete.healthname ?? '',
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03)),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await deletHealthyDietFAvorite(
                                        context, Diete);
                                  },
                                  icon: Icon(
                                      Diete.favorite == true
                                          ? Icons.favorite
                                          : Icons.favorite_outline_rounded,
                                      color: Diete.favorite == true
                                          ? appcolorpink
                                          : appcolorRed))),
                        )
                      ])),
                    );
                  },
                );
        },
      ),
    );
  }
}
