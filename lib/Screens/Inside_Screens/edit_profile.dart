import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key, this.id});

  final String? id;

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userDatas,
        builder: (_, user, __) {
          // ignore: unused_local_variable
          final details = user.firstWhere((e) => e.id == id);

          // ignore: unnecessary_null_comparison
          if (details != null) {
            _ageController.text = details.age ?? '';
            _heightController.text = details.height ?? '';
            _weightController.text = details.weight ?? '';
          }

          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel)),
                title: Text(
                  'Edit Profile',
                  style: GoogleFonts.fredoka(),
                ),
                actions: [
                  IconButton(
                      onPressed: () async {
                        await addUserDetails(details);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.check))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final imagepath = await pickImage();
                        // ignore: unnecessary_null_comparison
                        if (imagepath != null && user != null) {
                          details.imagePath = imagepath;
                          getData();
                          await details.save();
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: isDark.value
                            ?appcolorRed
                            : const Color.fromARGB(255, 237, 148, 142),
                        radius: 50,
                        backgroundImage: details.imagePath != null
                            ? FileImage(File(details.imagePath!))
                            : null,
                        child: details.imagePath == null
                            ? const Icon(
                                Icons.camera_alt_rounded,
                                size: 30,
                              )
                            : null,
                      ),
                    ),
                    Text(
                      'Edit Picture',
                      style: GoogleFonts.josefinSans(fontSize: 20),
                    ),
                    TextField(
                      maxLength: 2,
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Age"),
                          hintText: 'Age',
                          hintStyle: GoogleFonts.josefinSans(fontSize: 14),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:appcolorRed))),
                    ),
                    TextField(
                      maxLength: 3,
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Height"),
                          hintText: 'Height',
                          hintStyle: GoogleFonts.josefinSans(fontSize: 14),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:appcolorRed))),
                    ),
                    TextField(
                      maxLength: 3,
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Weight"),
                          hintText: 'Weight',
                          hintStyle: GoogleFonts.josefinSans(fontSize: 14),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:appcolorRed))),
                    ),
                  ],
                ),
              ));
        });
  }

  Future<void> addUserDetails(Usermodel user) async {
    try {
      // Update user properties
      user.age = _ageController.text;
      user.height = _heightController.text;
      user.weight = _weightController.text;

      // Open the Hive box and save the user
      final db = await Hive.openBox<Usermodel>('UserBox');
      if (db.containsKey(user.id)) {
        await db.put(user.id, user);
      } else {
        throw Exception('User not found in the database.');
      }

      // Update userDatas and notify listeners
      userDatas.value = db.values.toList();
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      userDatas.notifyListeners();
    } catch (e) {
      debugPrint('Error updating user details: $e');
    }
  }
}

Future<String?> pickImage() async {
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  } catch (e) {
    return null;
  }
}

Future<String?> pickVideo() async {
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    return pickedFile?.path;
  } catch (e) {
    return null;
  }
}

void calculateBMI(TextEditingController heightController,
    TextEditingController weightController, double result) {
  double height = double.parse(heightController.text) / 100;
  double weight = double.parse(weightController.text);

  double heightSquare = height * height;
  double result = weight / heightSquare;
  result = result;
}
