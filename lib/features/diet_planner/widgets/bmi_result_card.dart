import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BmiResultCard extends StatelessWidget {
  const BmiResultCard({
    super.key,
    required this.bmiList,
    required this.screenWidth,
    this.categoryColor,
  });

  final List<BmiCalculate> bmiList;
  final double screenWidth;
  final Color? categoryColor;

  @override
  Widget build(BuildContext context) {
    if (bmiList.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: screenWidth * 0.8,
      height: screenWidth * 0.22,
      child: ListView(
        children: bmiList.map((bmiData) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: appcolorRed.withValues(alpha: 0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bmiData.bmiresult == null
                        ? "Calculate BMI"
                        : "BMI: ${bmiData.bmiresult?.toStringAsFixed(2)}",
                    style: GoogleFonts.jost(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bmiData.bmicategorry == null
                        ? "Category:"
                        : "Category: ${bmiData.bmicategorry}",
                    style: GoogleFonts.jost(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                      color: categoryColor ?? appcolorpink,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
