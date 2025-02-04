// ignore_for_file: deprecated_member_use

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/bmi_calculator.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/healty_diets.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/calendar_events_scree.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/customize_screen.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/DietPlanner/calorie_calculator.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/home_screen.dart';
import 'package:fit_form/Screens/Bottom_Nav_Screens.dart/profile.screen.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNaveScreen extends StatefulWidget {
  const BottomNaveScreen({super.key, this.id});
  final String? id;

  @override
  State<BottomNaveScreen> createState() => _BottomNaveScreenState();
}

class _BottomNaveScreenState extends State<BottomNaveScreen> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    getData();

    _screens = [
      HomeScreen(id: widget.id),
      const CalendarEvents(),
      Container(),
      CustomizeWorkoutScreen(id: widget.id),
      ProfileScreen(id: widget.id)
    ];
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      showDietPlannerModal(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: appcolorblack.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 3,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: isDark.value
                ? const Color.fromARGB(255, 37, 36, 36)
                : appcolorwhite,
            selectedItemColor: appcolorRed,
            unselectedItemColor: isDark.value ? appcolorwhite : appcolorblack,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: 'Diet Track',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center_sharp),
                label: 'Customize',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_pin),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDietPlannerModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              color: isDark.value
                  ? const Color.fromARGB(255, 37, 36, 36)
                  : appcolorwhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: appcolorgrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _buildModalOption(
                  icon: Icons.trending_up_outlined,
                  label: 'BMI Calculator',
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            BmiCalculator(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ),
                    );
                  },
                ),
                _buildModalOption(
                    icon: Icons.calculate,
                    label: 'Calorie Calculator',
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAninmation) =>
                                  CalorieCalculator(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                      );
                    }),
                _buildModalOption(
                  icon: Icons.food_bank,
                  label: "  Healthy Diet ",
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            HealthyDietPlannerScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ),
                    );
                  },
                )
              ])
            ])));
  }

  Widget _buildModalOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appcolorRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: appcolorRed,
                ),
              ),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jost(
                      fontSize: 16,
                      color: isDark.value ? appcolorwhite : appcolorblack))
            ])));
  }
}
