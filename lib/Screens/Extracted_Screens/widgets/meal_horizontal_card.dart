import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Inside_Screens/healthy_show.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/models/healty_diet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealHorizontalCard extends StatelessWidget {
  const MealHorizontalCard({
    super.key,
    required this.diet,
    required this.isDark,
  });

  final HealtyDiet diet;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final favoriteNotifier = ValueNotifier<bool>(diet.favorite ?? false);
    final hasValidImg =
        diet.healthimage != null && File(diet.healthimage!).existsSync();

    return Container(
      width: 175,
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 34, 34, 34)
            : const Color.fromARGB(255, 246, 246, 248),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Favorite Icon Overlay
          Stack(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, anim, secAnim) =>
                        HealthyDietShowScreen(diet: diet),
                    transitionsBuilder: (_, anim, secAnim, child) =>
                        FadeTransition(opacity: anim, child: child),
                  ),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: hasValidImg
                      ? Image.file(
                          File(diet.healthimage!),
                          width: 175,
                          height: 110,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'asset/Diet_Plans_Images/HealthyDiet2.jpg',
                          width: 175,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: ValueListenableBuilder<bool>(
                  valueListenable: favoriteNotifier,
                  builder: (context, isFavorite, _) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(6),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFavorite ? appcolorpink : Colors.white,
                        ),
                        onPressed: () async {
                          favoriteNotifier.value = !isFavorite;
                          diet.favorite = favoriteNotifier.value;
                          await editHealthyDiet(diet.id!, diet);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diet.healthname ?? 'Meal',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.jost(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? appcolorwhite : appcolorblack,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: appcolorRed.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${diet.healthcalories?.toStringAsFixed(0) ?? 0} kcal',
                    style: GoogleFonts.jost(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: appcolorRed,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
