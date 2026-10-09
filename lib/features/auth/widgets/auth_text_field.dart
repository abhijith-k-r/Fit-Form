import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isObscure;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 35, 0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.josefinSans(
              color: appcolorwhite, fontSize: 14, fontWeight: FontWeight.bold),
          prefixIcon: Icon(icon, color: appcolorwhite),
          suffixIcon: suffixIcon,
        ),
        style: GoogleFonts.jost(
            color: appcolorwhite, fontSize: 16, fontWeight: FontWeight.bold),
        validator: validator,
      ),
    );
  }
}
