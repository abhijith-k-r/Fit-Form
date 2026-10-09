import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Inside_Screens/add_bmi.dart';
import 'package:fit_form/features/diet_planner/data/bmi_calculation_service.dart';
import 'package:fit_form/features/diet_planner/widgets/bmi_calculator_body.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/bmi_calculate.dart';
import 'package:fit_form/models/bmi_calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final _hCtrl = TextEditingController(), _wCtrl = TextEditingController();
  Color? _catColor;
  Box<BmiCalculate>? _box;
  List<BmiCalculate> _list = [];
  List<BmiInstruction> _instructions = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Hive.openBox<BmiInstruction>('bmiInstructions');
    _box = await Hive.openBox<BmiCalculate>('bmiCalculations');
    _load();
  }

  void _load() {
    if (_box != null && mounted) setState(() => _list = _box!.values.toList());
  }

  void _loadInstructions(String? cat) {
    if (cat != null) {
      final b = Hive.box<BmiInstruction>('bmiInstructions');
      setState(() => _instructions = b.values.where((i) => i.category == cat).toList());
    }
  }

  void _calc() {
    final res = BmiCalculationService.calculateAndSave(
      heightText: _hCtrl.text,
      weightText: _wCtrl.text,
      box: _box,
    );
    if (res == null) {
      snackBarMessenger(context, "Valid Height & Weight required!", appcolorRed);
      return;
    }
    _load();
    setState(() => _catColor = res.color);
    _loadInstructions(res.category);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, dark, _) => Scaffold(
        backgroundColor: dark ? appcolorblack : appcolorwhite,
        appBar: AppBar(
          backgroundColor: dark ? appcolorblack : appcolorwhite,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BmiAddScree()))
                  .then((_) => _loadInstructions(_list.isNotEmpty ? _list.last.bmicategorry : null)),
              icon: const Icon(Icons.add_circle_outline_rounded, size: 30),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: BmiCalculatorBody(
          heightController: _hCtrl,
          weightController: _wCtrl,
          box: _box,
          list: _list,
          instructions: _instructions,
          categoryColor: _catColor,
          onCalculate: _calc,
          onClear: _load,
        ),
      ),
    );
  }
}
