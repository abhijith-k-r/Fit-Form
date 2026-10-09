import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onChanged;

  const CustomAppbar({
    super.key,
    required this.searchController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: TextFormField(
          controller: searchController,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Search Your Workouts',
            hintStyle: TextStyle(color: appcolorRed),
            prefixIcon: Icon(Icons.search, color: appcolorRed),
            fillColor: isDark.value ? appcolorblack : appcolorwhite,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 1),
          ),
        ),
      ),
    );
  }
}
