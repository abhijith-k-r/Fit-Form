import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/user_details.dart';
import 'package:fit_form/features/profile/screens/edit_profile.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.profile,
    required this.isDarkMode,
  });

  final Usermodel profile;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final hasValidImage = profile.imagePath != null &&
        File(profile.imagePath!).existsSync();

    final displayName = (profile.fullName != null &&
            profile.fullName!.trim().isNotEmpty &&
            profile.fullName!.trim().toLowerCase() != 'abhijith')
        ? profile.fullName!
        : 'Fitness Enthusiast';

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 56,
              backgroundColor: appcolorRed.withValues(alpha: 0.2),
              backgroundImage:
                  hasValidImage ? FileImage(File(profile.imagePath!)) : null,
              child: !hasValidImage
                  ? Icon(
                      Icons.person_rounded,
                      size: 56,
                      color: isDarkMode ? appcolorwhite : appcolorblack,
                    )
                  : null,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, anim, secAnim) =>
                        EditProfile(id: profile.id),
                    transitionsBuilder: (_, anim, secAnim, child) =>
                        FadeTransition(opacity: anim, child: child),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: appcolorRed,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDarkMode ? appcolorblack : appcolorwhite,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          displayName,
          style: GoogleFonts.fredoka(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? appcolorwhite : appcolorblack,
          ),
        ),
        const SizedBox(height: 16),
        UserDetails(id: profile.id),
      ],
    );
  }
}
