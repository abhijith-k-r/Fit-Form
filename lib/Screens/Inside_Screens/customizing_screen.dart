import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CustomizingScreen extends StatefulWidget {
  const CustomizingScreen({super.key});

  @override
  State<CustomizingScreen> createState() => _CustomizingScreenState();
}

class _CustomizingScreenState extends State<CustomizingScreen> {
  // final WorkoutService _workoutService = WorkoutService();

  // ignore: unused_field
  // List<WorkoutsModel> _workouts = [];
  XFile? _selectedImage;

  Future<void> _loadWorkout() async {
    // _workouts = await _workoutService.getWorkouts();

    setState(() {});
  }

  @override
  void initState() {
    _loadWorkout();
    super.initState();
  }

  String? selectedSet;
  String? selectedRep;
  String? selectedRestTime;
  String? selectedDuration;

  final TextEditingController workoutNameController = TextEditingController();
  final TextEditingController benefitsController = TextEditingController();
  final TextEditingController workoutStepsController = TextEditingController();
  final TextEditingController noofsetsController = TextEditingController();
  final TextEditingController repeateController = TextEditingController();
  final TextEditingController resttimeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  List<String> numbers = List.generate(13, (index) => (index + 0).toString());

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customize',
          style: GoogleFonts.jost(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                controller: workoutNameController,
                decoration: InputDecoration(
                    hintText: 'Workout Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: appcolorgrey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _selectedImage == null
                      ? const Icon(Icons.image_outlined, size: 60)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(_selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  ListTile(
                    title: Text("No of Sets"),
                    trailing: SizedBox(
                      width: 70,
                      height: 30,
                      child: TextField(
                        controller: noofsetsController,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("No of Reps"),
                    trailing: SizedBox(
                      width: 70,
                      height: 30,
                      child: TextField(
                        controller: repeateController,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Rest time"),
                    trailing: SizedBox(
                      width: 70,
                      height: 30,
                      child: TextField(
                        controller: resttimeController,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Total Duration "),
                    trailing: SizedBox(
                      width: 70,
                      height: 30,
                      child: TextField(
                        controller: durationController,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 355,
              height: 120,
              child: TextField(
                controller: benefitsController,
                decoration: InputDecoration(
                    focusColor: appcolorRed,
                    prefix: Icon(Icons.edit),
                    hintText: 'Benifits of workout ',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                maxLines: 3,
              ),
            ),
            SizedBox(
              width: 355,
              height: 120,
              child: TextField(
                controller: workoutStepsController,
                decoration: InputDecoration(
                    prefix: Icon(Icons.edit),
                    hintText: 'Steps of workout',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                maxLines: 3,
              ),
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: appcolorRed,
                  minimumSize: const Size(240, 42),
                  side:  BorderSide(color: appcolorblack, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () async {
              
                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(
                  'Add',
                  style: GoogleFonts.fredoka(
                      color: appcolorwhite, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
