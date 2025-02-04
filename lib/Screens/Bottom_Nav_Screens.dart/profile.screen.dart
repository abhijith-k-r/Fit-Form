import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/logout_function.dart';
import 'package:fit_form/Screens/Extracted_Screens/user_details.dart';
import 'package:fit_form/Screens/Inside_Screens/edit_profile.dart';
import 'package:fit_form/Screens/Inside_Screens/favorite_screen.dart';
import 'package:fit_form/Screens/Inside_Screens/settings.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.id});

  final String? id;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
          final profile = user.firstWhere((elemnt) => elemnt.id == widget.id);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: GoogleFonts.fredoka(
                  fontSize: 30,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: isDark.value
                          ? appcolorRed
                          : const Color.fromARGB(255, 237, 148, 142),
                      radius: screenWidth * 0.15,
                      backgroundImage: profile.imagePath != null
                          ? FileImage(File(profile.imagePath!))
                          : null,
                      child: profile.imagePath == null
                          ? Icon(
                              Icons.person,
                              size: screenWidth * 0.2,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${profile.fullName}',
                    style: GoogleFonts.fredoka(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${profile.email}',
                    style: GoogleFonts.jost(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  // ! USER_DETAILS <>><>
                  UserDetails(id: widget.id),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(26, 0, 26, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark.value
                            ? const Color.fromARGB(255, 37, 36, 36)
                            : appcolorwhite,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: screenWidth * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (conext, animation,
                                            secondaryAnimation) =>
                                        EditProfile(
                                      id: widget.id,
                                    ),
                                    transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  ));
                            },
                            leading: Icon(
                              Icons.edit_square,
                              color: appcolorRed,
                              size: screenWidth * 0.05,
                            ),
                            title: Text(
                              'Edit Profile',
                              style: GoogleFonts.jost(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w400),
                            ),
                            trailing: Icon(
                              Icons.chevron_right_rounded,
                              size: screenWidth * 0.05,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const FavoriteScreen(),
                                    transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  ));
                            },
                            leading: Icon(
                              Icons.favorite_outline_sharp,
                              color: appcolorRed,
                              size: screenWidth * 0.05,
                            ),
                            title: Text(
                              'Favorite',
                              style: GoogleFonts.jost(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w400),
                            ),
                            trailing: Icon(
                              Icons.chevron_right_rounded,
                              size: screenWidth * 0.05,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const SettingsScreen(),
                                    transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  ));
                            },
                            leading: Icon(
                              Icons.settings,
                              color: appcolorRed,
                              size: screenWidth * 0.05,
                            ),
                            title: Text(
                              'Settings',
                              style: GoogleFonts.jost(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: Icon(
                              Icons.chevron_right_rounded,
                              size: screenWidth * 0.05,
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.dark_mode_outlined,
                              color: appcolorRed,
                              size: screenWidth * 0.05,
                            ),
                            title: Text(
                              'Dark Mode',
                              style: GoogleFonts.jost(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w400),
                            ),
                            trailing: Switch(
                              value: isDark.value,
                              activeColor: appcolorRed,
                              onChanged: (value) {
                                setState(() {
                                  isDark.value = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              showIsLogOut(context, profile.id);
                            },
                            leading: Icon(
                              Icons.logout,
                              color: appcolorRed,
                              size: screenWidth * 0.05,
                            ),
                            title: Text(
                              'Log out',
                              style: GoogleFonts.jost(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
