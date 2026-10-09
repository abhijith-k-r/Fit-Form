import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Extracted_Screens/diet_planner.dart';
import 'package:fit_form/features/diet_planner/widgets/diet_planner_fab.dart';
import 'package:fit_form/functions/health_diet.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HealthyDietPlannerScreen extends StatefulWidget {
  const HealthyDietPlannerScreen({super.key});

  @override
  State<HealthyDietPlannerScreen> createState() => _HealthyDietPlannerScreenState();
}

class _HealthyDietPlannerScreenState extends State<HealthyDietPlannerScreen> {
  List<BmiCalculate> _bmiCalculateList = [];

  @override
  void initState() {
    super.initState();
    _loadbmiHistory();
    healthyDietInitialize();
  }

  void _loadbmiHistory() async {
    try {
      final bmicalculatBox = await Hive.openBox<BmiCalculate>('bmiCalculations');
      if (mounted) {
        setState(() => _bmiCalculateList = bmicalculatBox.values.toList());
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final latestBmiData = _bmiCalculateList.isNotEmpty ? _bmiCalculateList.last : null;
    final bmiCategory = latestBmiData?.bmicategorry ?? '';

    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, isDarkMode, _) {
        return Scaffold(
          backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
          appBar: AppBar(
            backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
            elevation: 0,
            title: Text(
              'Healthy Diet Planner',
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildPersonalizedRecommendations(_bmiCalculateList),
                predefinedDietCategories(context, bmiCategory),
                buildMealTrackingSection(context),
              ],
            ),
          ),
          floatingActionButton: const DietPlannerFab(),
        );
      },
    );
  }
}
