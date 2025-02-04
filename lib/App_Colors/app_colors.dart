import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



dynamic appcolorRed = Colors.red;
dynamic appcolorblack = Colors.black;
dynamic appcolorwhite = Colors.white;
dynamic appcolorblue = Colors.blue;
dynamic appcolorgreen = Colors.green;
dynamic appcolororang = Colors.orange;
dynamic appcoloryellow = Colors.yellow;
dynamic appcolorgrey = Colors.grey;
dynamic appcolorpink = Colors.pink;


// ! Colors_Gradiean >< <> ><

ShaderMask LinearColors(Color color, Color colorr, String text, double size) {
  return ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
      colors: [color, colorr],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds),
    child: Text(
      text,
      style: GoogleFonts.jost(
          fontSize: size, fontWeight: FontWeight.w600, color: appcolorwhite),
    ),
  );
}
