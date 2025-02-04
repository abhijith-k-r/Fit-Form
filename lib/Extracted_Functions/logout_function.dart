import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showIsLogOut(BuildContext contxt, String? data) {
  if (data == null) {
    showDialog(
      context: contxt,
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
            onPressed: () => Navigator.pop(contxt),
            child: Text('OK'),
          ),
        ],
      ),
    );
    return;
  }

  // fetchUserData(data);
  showDialog(
    context: contxt,
    builder: (BuildContext contxt) {
      return Center(
          child: AlertDialog(
              title: const Text(
                'Log out of your\naccount?',
                textAlign: TextAlign.center,
              ),
              actions: [
            Center(
                child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    logOut(data, contxt);
                  },
                  child: Text(
                    'Log out',
                    style: GoogleFonts.jost(
                      color: appcolorRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(contxt);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.jost(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ))
          ]));
    },
  );
}


