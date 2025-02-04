// ignore_for_file: unnecessary_null_comparison, unused_field, empty_catches

import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/delet_funcion.dart';
import 'package:fit_form/Screens/Extracted_Screens/diet_planner.dart';
import 'package:fit_form/Screens/Inside_Screens/add_bmi.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:fit_form/models/bmi_calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _result;
  String? _category;
  Color? _categoryColor;

  Box<BmiCalculate>? _bmiCalculateBox;
  List<BmiCalculate> _bmiCalculateList = [];

  List<BmiInstruction> _matchingInstruction = [];
  late Box<BmiInstruction> _bmiBox;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    try {
      _bmiBox = await Hive.openBox<BmiInstruction>('bmiInstructions');
      _bmiCalculateBox ??= await Hive.openBox<BmiCalculate>('bmiCalculations');

      setState(() {
        _loadBmiHistory();
      });
    } catch (e) {}
  }

  Map<String, dynamic> _getBmiCategory(double bmi) {
    if (bmi < 18.5) return {'category': 'UnderWeight', 'color': appcolorblue};
    if (bmi < 24.9) return {'category': 'Normal', 'color': appcolorgreen};
    if (bmi < 29.9) return {'category': 'OverWeight', 'color': appcolororang};
    return {'category': 'Obese', 'color': appcolorRed};
  }

  void _loadMatchingInstructions() {
    if (_category == null) return;

    final box = Hive.box<BmiInstruction>('bmiInstructions');
    _matchingInstruction = box.values
        .where((instruction) => instruction.category == _category)
        .toList();
    setState(() {});
  }

  void _loadBmiHistory() {
    if (_bmiCalculateBox != null) {
      setState(() {
        _bmiCalculateList = _bmiCalculateBox!.values.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (contexr, animation, secondaryAnimation) =>
                        BmiAddScree(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                ).then((_) => _loadMatchingInstructions());
              },
              icon: Icon(
                Icons.add_circle_outline_rounded,
                size: 30,
              )),
          SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          spacing: 20,
          children: [
            const SizedBox(height: 20),
            bmiCalculatorCarousel(context, carousalItemss),
            bmiTextfield(
                _heightController, 'height in cm', Icon(Icons.trending_up)),
            bmiTextfield(
                _weightController, 'weight in kg', Icon(Icons.line_weight)),
            _bmiCalculateBox != null && _bmiCalculateBox!.isNotEmpty
                ? textButton(() {
                    calculateDelet(context, _bmiCalculateBox!, _loadBmiHistory);
                    // clearAllBmiHistory();
                  }, "Clear BMI", EdgeInsets.zero, appcolorRed)
                : textButton(
                    calculateBMI, 'Calculate', EdgeInsets.zero, appcolorgreen),
            SizedBox(
              width: screenWidth * 0.8,
              height: screenWidth * 0.2,
              child: ListView(
                children: _bmiCalculateList.map((bmiData) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 8.0), 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appcolorRed.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                          10.0), 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, 
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
                          SizedBox(height: 5), 
                          Text(
                            bmiData.bmicategorry == null
                                ? "Category:"
                                : "Category:${bmiData.bmicategorry}",
                            style: GoogleFonts.jost(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color: _categoryColor ?? appcolorpink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            ..._matchingInstruction.map(
              (instruction) => SizedBox(
                width: screenWidth * 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: appcolorRed.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Image.file(
                        File(instruction.imagepath!),
                        height: screenWidth * 0.8,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          instruction.descripion!,
                          style: GoogleFonts.jost(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
      snackBarMessenger(
          context, "Please Fill Your Height and Weight", appcolorRed);
      return;
    }

    try {
      double height = double.parse(_heightController.text) / 100;
      double weight = double.parse(_weightController.text);
      double heightSquare = height * height;
      double result = weight / heightSquare;

      if (height <= 0 || height > 251 || weight <= 0 || weight > 635) {
        snackBarMessenger(
            context, "Height and Weight must be Valid!", appcolorRed);
        return;
      }

      final categoryData = _getBmiCategory(result);

      final bmiHistory = BmiCalculate(
          height: height * 100,
          weight: weight,
          bmiresult: result,
          bmicategorry: categoryData['category'] as String,
          timestamp: DateTime.now());

      _bmiCalculateBox!.add(bmiHistory);
      _loadBmiHistory();

      setState(() {
        _result = result;
        _category = categoryData['category'] as String;
        _categoryColor = categoryData['color'] as Color;
      });
    } catch (e) {
      snackBarMessenger(
          context, "Invalid input. Please enter numbers only!", appcolorRed);
    }
    _loadMatchingInstructions();
  }
}
