import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileEditForm extends StatelessWidget {
  const ProfileEditForm({
    super.key,
    required this.nameController,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.isDarkMode,
  });

  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          controller: nameController,
          label: 'Full Name',
          icon: Icons.badge_outlined,
          isDark: isDarkMode,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: ageController,
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
                controller: heightController,
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
          controller: weightController,
          label: 'Weight (kg)',
          icon: Icons.monitor_weight_outlined,
          isDark: isDarkMode,
          keyboardType: TextInputType.number,
          maxLength: 3,
        ),
      ],
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
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          maxLength,
        }) =>
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
