// ignore_for_file: unnecessary_null_comparison

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    super.key,
    this.id,
  });

  final String? id;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: userDatas,
      builder: (context, user, child) {
        if (user.isEmpty) {
          return Center(
            child: Text(
              'No user data found.',
              style: GoogleFonts.jost(
                fontSize: 18,
                color: isDark.value ? appcolorwhite : appcolorblack,
              ),
            ),
          );
        }

        final details = user.firstWhere((element) => element.id == widget.id);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 30,
            children: [
              _buildRichText(
                value: details.height ?? '_',
                unit: ' cm',
                label: 'Height',
              ),
              _buildRichText(
                value: details.age ?? '_',
                unit: ' y-o',
                label: 'Age',
              ),
              _buildRichText(
                value: details.weight ?? '_',
                unit: ' kg',
                label: 'Weight',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRichText({
    required String value,
    required String unit,
    required String label,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: value,
        style: GoogleFonts.jost(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w600,
          color: isDark.value ? appcolorwhite : appcolorblack,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '$unit\n',
            style: GoogleFonts.jost(fontSize: screenWidth * 0.07),
          ),
          TextSpan(
            text: label,
            style: GoogleFonts.jost(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
