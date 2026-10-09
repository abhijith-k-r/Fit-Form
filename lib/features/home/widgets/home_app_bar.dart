import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/homescreen_profile.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.user,
    required this.isDarkMode,
  });

  final Usermodel user;
  final bool isDarkMode;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final hasName = user.fullName != null &&
        user.fullName!.trim().isNotEmpty &&
        user.fullName!.trim().toLowerCase() != 'abhijith';

    return AppBar(
      backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        hasName ? 'Hello ${user.fullName} !' : 'Hello Athlete !',
        style: GoogleFonts.fredoka(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: isDarkMode ? appcolorwhite : appcolorblack,
        ),
      ),
      actions: [
        InkWell(
          onTap: () => show_HomeScree_Popup_Profile(context, user.id),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: appcolorRed,
            backgroundImage: user.imagePath != null &&
                    File(user.imagePath!).existsSync()
                ? FileImage(File(user.imagePath!))
                : null,
            child: (user.imagePath == null ||
                    !File(user.imagePath!).existsSync())
                ? Icon(Icons.person, color: appcolorwhite, size: 22)
                : null,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
