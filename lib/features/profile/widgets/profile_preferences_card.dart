import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Inside_Screens/favorite_screen.dart';
import 'package:fit_form/Screens/Inside_Screens/settings.dart';
import 'package:fit_form/features/profile/screens/edit_profile.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePreferencesCard extends StatefulWidget {
  const ProfilePreferencesCard({
    super.key,
    required this.userId,
    required this.isDarkMode,
  });

  final String? userId;
  final bool isDarkMode;

  @override
  State<ProfilePreferencesCard> createState() => _ProfilePreferencesCardState();
}

class _ProfilePreferencesCardState extends State<ProfilePreferencesCard> {
  @override
  Widget build(BuildContext context) {
    final cardBg = widget.isDarkMode
        ? const Color.fromARGB(255, 34, 34, 34)
        : const Color.fromARGB(255, 245, 245, 247);

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, anim, secAnim) =>
                      EditProfile(id: widget.userId),
                  transitionsBuilder: (_, anim, secAnim, child) =>
                      FadeTransition(opacity: anim, child: child),
                ),
              );
            },
            leading: Icon(Icons.edit_square, color: appcolorRed, size: 22),
            title: Text(
              'Edit Profile',
              style: GoogleFonts.jost(
                fontSize: 16,
                color: widget.isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, anim, secAnim) =>
                      const FavoriteScreen(),
                  transitionsBuilder: (_, anim, secAnim, child) =>
                      FadeTransition(opacity: anim, child: child),
                ),
              );
            },
            leading: Icon(Icons.favorite_outline_sharp,
                color: appcolorRed, size: 22),
            title: Text(
              'Favorite Workouts',
              style: GoogleFonts.jost(
                fontSize: 16,
                color: widget.isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, anim, secAnim) =>
                      const SettingsScreen(),
                  transitionsBuilder: (_, anim, secAnim, child) =>
                      FadeTransition(opacity: anim, child: child),
                ),
              );
            },
            leading: Icon(Icons.settings, color: appcolorRed, size: 22),
            title: Text(
              'Settings',
              style: GoogleFonts.jost(
                fontSize: 16,
                color: widget.isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: Icon(Icons.dark_mode_outlined, color: appcolorRed, size: 22),
            title: Text(
              'Dark Mode',
              style: GoogleFonts.jost(
                fontSize: 16,
                color: widget.isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
            trailing: Switch(
              value: isDark.value,
              activeThumbColor: appcolorRed,
              onChanged: (value) {
                setState(() {
                  isDark.value = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
