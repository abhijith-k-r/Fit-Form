import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/models/bmi_calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BmiInstructionList extends StatelessWidget {
  const BmiInstructionList({
    super.key,
    required this.instructions,
    required this.screenWidth,
  });

  final List<BmiInstruction> instructions;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    if (instructions.isEmpty) return const SizedBox.shrink();

    return Column(
      children: instructions.map((instruction) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            width: screenWidth * 0.9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: appcolorRed.withValues(alpha: 0.1),
              ),
              child: Column(
                children: [
                  if (instruction.imagepath != null &&
                      File(instruction.imagepath!).existsSync())
                    Image.file(
                      File(instruction.imagepath!),
                      height: screenWidth * 0.8,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      instruction.descripion ?? '',
                      style: GoogleFonts.jost(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
