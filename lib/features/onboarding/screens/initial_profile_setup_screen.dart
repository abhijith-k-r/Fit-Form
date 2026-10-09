// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/home/screens/bottom_nave_screen.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class InitialProfileSetupScreen extends StatefulWidget {
  const InitialProfileSetupScreen({super.key});

  @override
  State<InitialProfileSetupScreen> createState() =>
      _InitialProfileSetupScreenState();
}

class _InitialProfileSetupScreenState extends State<InitialProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (pickedFile != null) {
        setState(() {
          _selectedImagePath = pickedFile.path;
        });
      }
    } catch (_) {}
  }

  Future<void> _saveAndNavigate([bool isSkipped = false]) async {
    final name = isSkipped || _nameController.text.trim().isEmpty
        ? 'Fitness Champ'
        : _nameController.text.trim();

    final user = Usermodel(
      fullName: name,
      age: _ageController.text.trim(),
      height: _heightController.text.trim(),
      weight: _weightController.text.trim(),
      imagePath: _selectedImagePath,
      isLog: true,
      email: '',
      password: '',
    );

    await addSignUp(user);
    await getData();

    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, secAnim) =>
            BottomNaveScreen(id: user.id),
        transitionsBuilder: (context, anim, secAnim, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              TextButton(
                onPressed: () => _saveAndNavigate(true),
                child: Text(
                  'Skip',
                  style: GoogleFonts.jost(
                    color: appcolorRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create Your Profile',
                    style: GoogleFonts.fredoka(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? appcolorwhite : appcolorblack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Personalize FitForm for your personal fitness journey',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.jost(
                      fontSize: 15,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 54,
                          backgroundColor: appcolorRed.withOpacity(0.15),
                          backgroundImage: _selectedImagePath != null
                              ? FileImage(File(_selectedImagePath!))
                              : null,
                          child: _selectedImagePath == null
                              ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: appcolorRed,
                                )
                              : null,
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: appcolorRed,
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tap to add photo',
                    style: GoogleFonts.jost(
                      fontSize: 13,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildInputCard(
                    controller: _nameController,
                    label: 'Full Name',
                    hint: 'e.g. Alex Johnson',
                    icon: Icons.badge_outlined,
                    isDark: isDarkMode,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputCard(
                          controller: _ageController,
                          label: 'Age',
                          hint: 'e.g. 25',
                          icon: Icons.calendar_today_outlined,
                          isDark: isDarkMode,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInputCard(
                          controller: _heightController,
                          label: 'Height (cm)',
                          hint: 'e.g. 175',
                          icon: Icons.height,
                          isDark: isDarkMode,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildInputCard(
                    controller: _weightController,
                    label: 'Weight (kg)',
                    hint: 'e.g. 70',
                    icon: Icons.monitor_weight_outlined,
                    isDark: isDarkMode,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => _saveAndNavigate(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appcolorRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.jost(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: appcolorwhite,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputCard({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 34, 34, 34)
            : const Color.fromARGB(255, 245, 245, 247),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.06),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        buildCounter: (context,
                {required currentLength, required isFocused, maxLength}) =>
            null,
        style: GoogleFonts.jost(
          color: isDark ? appcolorwhite : appcolorblack,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          icon: Icon(icon, color: appcolorRed, size: 22),
          border: InputBorder.none,
          labelText: label,
          labelStyle: GoogleFonts.jost(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            fontSize: 13,
          ),
          hintText: hint,
          hintStyle: GoogleFonts.jost(
            color: Colors.grey[500],
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
