// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps, unused_import
import 'dart:io';
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Extracted_Functions/diet_tracker.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/bmi_calculator.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/healty_diets.dart' as diet_planner;
import 'package:fit_form/Screens/Extracted_Screens/delet_funcion.dart';
import 'package:fit_form/functions/bmi_functio.dart';
import 'package:fit_form/models/bmi_calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class BmiAddScree extends StatefulWidget {
  const BmiAddScree({super.key});

  @override
  State<BmiAddScree> createState() => _BmiAddScreeState();
}

class _BmiAddScreeState extends State<BmiAddScree> {
  String? selectedImage;
  String? selectedCategory;
  final TextEditingController _descriptionController = TextEditingController();
  late Box<BmiInstruction> _bmiBox;
  bool _isLoading = false;
  BmiInstruction? existingIstructions;

  @override
  void initState() {
    super.initState();
    initHive();
  }

  Future<void> initHive() async {
    _bmiBox = await Hive.openBox<BmiInstruction>('bmiInstructions');
  }

  void _loadExistingData(String category) {
    final instructions = _bmiBox.values.toList();

    existingIstructions = instructions.firstWhere(
        (instruction) => instruction.category == category,
        orElse: () =>
            BmiInstruction(imagepath: '', descripion: '', category: category));

    if (existingIstructions!.imagepath!.isNotEmpty) {
      setState(() {
        selectedImage = existingIstructions!.imagepath;
        _descriptionController.text = existingIstructions!.descripion!;
      });
    } else {
      setState(() {
        selectedImage = null;
        _descriptionController.clear();
      });
    }
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() => selectedImage = image.path);
      }
    } catch (e) {
      snackBarMessenger(context, 'Error selecting image', appcolorRed);
    }
  }

  void saveInstruction() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Validate all fields
      if (selectedImage == null) {
        snackBarMessenger(context, 'Please select an image', appcolorRed);
        return;
      }

      if (_descriptionController.text.trim().isEmpty) {
        snackBarMessenger(context, 'Please enter a description', appcolorRed);
        return;
      }
      if (selectedCategory == null) {
        snackBarMessenger(context, 'Please select a category', appcolorRed);
        return;
      }

      // Create and save instruction
      final instruction = BmiInstruction(
        imagepath: selectedImage!,
        descripion: _descriptionController.text.trim(),
        category: selectedCategory!,
      );

      await _bmiBox.add(instruction);

      if (mounted) {
        snackBarMessenger(context, 'Saved successfully!', appcolorgreen);
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error saving instruction: $e");
      snackBarMessenger(context, 'Failed to save instruction', appcolorRed);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> updateInstruction() async {
    if (selectedCategory == null) {
      snackBarMessenger(context, 'please select a category', appcolorRed);
      return;
    }

    if (_descriptionController.text.trim().isEmpty) {
      snackBarMessenger(context, 'please enter a description', appcolorRed);
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final instrucons = _bmiBox.values.toList();
      final existingIndes = instrucons
          .indexWhere((instrucon) => instrucon.category == selectedCategory);

      final UpdatedInstruction = BmiInstruction(
          imagepath: selectedImage!,
          descripion: _descriptionController.text.trim(),
          category: selectedCategory!);

      if (existingIndes != -1) {
        await _bmiBox.putAt(existingIndes, UpdatedInstruction);
      } else {
        await _bmiBox.add(UpdatedInstruction);
      }

      if (mounted) {
        snackBarMessenger(context, 'Updated Successfully', appcolorgreen);
      }
    } catch (e) {
      snackBarMessenger(context, 'Failed to update instruction', appcolorRed);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> clearAll() async {
    if (selectedCategory == null) {
      snackBarMessenger(context, 'Please select a category', appcolorRed);
      return;
    }

    final shouldClear = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
                title: Text('Clear ${selectedCategory} Data?',
                    style: GoogleFonts.jost()),
                content: Text(
                    'Are you sure you want to delete all data for ${selectedCategory}? This cannot be undone.',
                    style: GoogleFonts.jost()),
                actions: [
                  textButton(() => Navigator.pop(context, false), 'CANCEL',
                      EdgeInsets.zero, appcolorblue),
                  textButton(() => Navigator.pop(context, true), 'DELETE',
                      EdgeInsets.zero, appcolorRed)
                ]));

    if (shouldClear != true) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final istructions = _bmiBox.values.toList();

      final existingIndex = istructions.indexWhere(
          (instructiion) => instructiion.category == selectedCategory);

      if (existingIndex != -1) {
        await _bmiBox.deleteAt(existingIndex);
        setState(() {
          selectedImage = null;
          _descriptionController.clear();
        });

        if (mounted) {
          snackBarMessenger(context, 'Cleared Successfully !', appcolorgreen);
        }
      } else {
        snackBarMessenger(context, 'No data found to clear', appcolorRed);
      }
    } catch (e) {
      snackBarMessenger(context, 'Failed to clear data', appcolorRed);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: _isLoading ? null : pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appcolorgrey,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(selectedImage!),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint("Error loading image: $error");
                              return Center(
                                child: Icon(Icons.error, color: appcolorRed),
                              );
                            },
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.image, size: 40),
                            Text(
                              'Click to upload',
                              style: TextStyle(
                                color: appcolorgrey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                enabled: !_isLoading,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: selectedCategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                items: ['UnderWeight', 'Normal', 'OverWeight', 'Obese']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    alignment: AlignmentDirectional.center,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: _isLoading
                    ? null
                    : (value) {
                        setState(() {
                          selectedCategory = value;
                          _loadExistingData(value!);
                          debugPrint("Category selected: $value");
                        });
                      },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: textButton(
                      () => _isLoading ? null : updateInstruction(),
                      _isLoading ? 'Updating...' : 'Update',
                      EdgeInsets.zero,
                      appcolorblue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: textButton(
                      () => _isLoading ? null : saveInstruction(),
                      _isLoading ? "Saving..." : "SAVE",
                      EdgeInsets.zero,
                      appcolorgreen,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: textButton(
                      () => _isLoading ? null : clearAll(),
                      _isLoading ? 'Clearing...' : 'Clear All',
                      EdgeInsets.zero,
                      appcolorRed,
                    ),
                  ),
                ],
              ),
            ])));
  }
}
