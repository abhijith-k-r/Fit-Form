import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

show_HomeScree_Popup_Profile(BuildContext context, String? data) {
  if (data == null) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Error',
          style: GoogleFonts.josefinSans(),
        ),
        content: Text(
          'No user data available.',
          style: GoogleFonts.jost(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
    return;
  }
  getData();
  showDialog(
      context: context,
      builder: (BuildContext context) => ValueListenableBuilder(
          valueListenable: userDatas,
          builder: (_, value, __) {
            final home = value.firstWhere((elements) => elements.id == data);
            return AlertDialog(
              backgroundColor: isDark.value ? appcolorblack: appcolorwhite,
              title: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    spacing: 45,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        'Profile',
                        style: GoogleFonts.josefinSans(),
                      ),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: isDark.value
                              ? const Color.fromARGB(255, 52, 52, 52)
                              : const Color.fromARGB(255, 231, 230, 230),
                          borderRadius: BorderRadius.circular(20)),
                      width: 300,
                      height: 150,
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isDark.value
                                  ? appcolorRed
                                  : const Color.fromARGB(255, 237, 148, 142),
                              radius: 25,
                              backgroundImage: home.imagePath != null
                                  ? FileImage(File(home.imagePath!))
                                  : null,
                              child: home.imagePath == null
                                  ? const Icon(
                                      Icons.person_pin,
                                      size: 20,
                                    )
                                  : null,
                            ),
                            title: Text(
                              '${home.fullName}',
                              style: GoogleFonts.jost(),
                            ),
                            subtitle: Text(
                              '${home.email}',
                              style: GoogleFonts.jost(fontSize: 12),
                            ),
                          ),
                          _buildUserStatRow('Age', home.age),
                          _buildUserStatRow('Heigt', home.height),
                          _buildUserStatRow('Weight', home.weight),
                        ],
                      )),
                ],
              ),
            );
          }));
}

Widget _buildUserStatRow(String label, String? value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        label,
        style: GoogleFonts.jost(fontSize: 15),
      ),
      Text(
        value?.isNotEmpty == true ? value! : 'Not set',
        style: GoogleFonts.jost(fontSize: 15),
      ),
    ],
  );
}