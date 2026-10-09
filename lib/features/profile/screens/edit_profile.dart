// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fit_form/core/services/media_picker_service.dart';
export 'package:fit_form/core/services/media_picker_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, this.id});

  final String? id;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String? _imagePath;
  bool _isInitialized = false;

  void _initFields(Usermodel user) {
    if (!_isInitialized) {
      _nameController.text = user.fullName ?? '';
      _ageController.text = user.age ?? '';
      _heightController.text = user.height ?? '';
      _weightController.text = user.weight ?? '';
      _imagePath = user.imagePath;
      _isInitialized = true;
    }
  }

  Future<void> _pickImage() async {
    final imagePath = await pickImage();
    if (imagePath != null) {
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  Future<void> _saveChanges(Usermodel user) async {
    try {
      user.fullName = _nameController.text.trim();
      user.age = _ageController.text.trim();
      user.height = _heightController.text.trim();
      user.weight = _weightController.text.trim();
      user.imagePath = _imagePath;

      final db = await Hive.openBox<Usermodel>('UserBox');
      if (db.containsKey(user.id)) {
        await db.put(user.id, user);
      } else {
        await db.put(user.id ?? 'user', user);
      }

      await getData();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Error updating user: $e');
    }
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
    return ValueListenableBuilder<List<Usermodel>>(
      valueListenable: userDatas,
      builder: (_, users, __) {
        if (users.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final details = users.firstWhere(
          (e) => e.id == widget.id,
          orElse: () => users.first,
        );
        _initFields(details);

        final isDarkMode = isDark.value;

        return Scaffold(
          backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
          appBar: AppBar(
            backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
            title: Text(
              'Edit Profile',
              style: GoogleFonts.fredoka(
                fontSize: 22,
                color: isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => _saveChanges(details),
                icon: Icon(Icons.check, color: appcolorRed, size: 28),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: appcolorRed.withOpacity(0.15),
                        backgroundImage: _imagePath != null
                            ? FileImage(File(_imagePath!))
                            : null,
                        child: _imagePath == null
                            ? Icon(
                                Icons.person,
                                size: 55,
                                color: appcolorRed,
                              )
                            : null,
                      ),
                      CircleAvatar(
                        radius: 17,
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
                  'Change Picture',
                  style: GoogleFonts.jost(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.badge_outlined,
                  isDark: isDarkMode,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _ageController,
                        label: 'Age',
                        icon: Icons.calendar_today_outlined,
                        isDark: isDarkMode,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _heightController,
                        label: 'Height (cm)',
                        icon: Icons.height,
                        isDark: isDarkMode,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildTextField(
                  controller: _weightController,
                  label: 'Weight (kg)',
                  icon: Icons.monitor_weight_outlined,
                  isDark: isDarkMode,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _saveChanges(details),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appcolorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
                      style: GoogleFonts.jost(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: appcolorwhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
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
        ),
      ),
    );
  }
}
