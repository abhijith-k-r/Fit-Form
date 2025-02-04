import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Inside_Screens/about_screen.dart';
import 'package:fit_form/Screens/Inside_Screens/help_screens.dart';
import 'package:fit_form/Screens/Inside_Screens/privacy_policy_screen.dart';
import 'package:fit_form/Screens/Inside_Screens/terms_condition.screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.fredoka(),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AboutScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ));
            },
            leading: Icon(color: appcolorRed, Icons.info),
            title: Text('About ', style: GoogleFonts.jost()),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HelpScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ));
            },
            leading: Icon(color: appcolorRed, Icons.help),
            title: Text('Help', style: GoogleFonts.jost()),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const PrivacyPolicyScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ));
            },
            leading: Icon(color: appcolorRed, Icons.privacy_tip_outlined),
            title: Text('Privacy Policy', style: GoogleFonts.jost()),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        TermsConditions(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ));
            },
            leading: Icon(color: appcolorRed, Icons.policy),
            title: Text('Terms & conditions', style: GoogleFonts.jost()),
          ),
        ],
      ),
    );
  }
}
