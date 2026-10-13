import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Inside_Screens/add_healty_diets.dart';
import 'package:fit_form/Screens/Inside_Screens/healty_favorite.dart';
import 'package:flutter/material.dart';

class DietPlannerFab extends StatelessWidget {
  const DietPlannerFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: FloatingActionButton(
            heroTag: 'addDiet',
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, animation, __) => AddHealtyDiets(),
                  transitionsBuilder: (_, animation, __, child) =>
                      FadeTransition(opacity: animation, child: child),
                ),
              );
            },
            backgroundColor: appcolorRed,
            child: const Icon(Icons.add),
          ),
        ),
        Positioned(
          bottom: 80,
          right: 5,
          child: FloatingActionButton(
            heroTag: 'favoriteDiet',
            mini: true,
            backgroundColor: appcolorwhite,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, animation, __) => const HealthyFavorite(),
                  transitionsBuilder: (_, animation, __, child) =>
                      FadeTransition(opacity: animation, child: child),
                ),
              );
            },
            child: Icon(Icons.favorite, color: appcolorRed),
          ),
        ),
      ],
    );
  }
}
