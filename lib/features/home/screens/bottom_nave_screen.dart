// ignore_for_file: deprecated_member_use

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/calendar_events/screens/calendar_events_scree.dart';
import 'package:fit_form/features/calendar_events/screens/customize_screen.dart';
import 'package:fit_form/features/diet_planner/screens/diet_track_menu_screen.dart';
import 'package:fit_form/features/home/screens/home_screen.dart';
import 'package:fit_form/features/profile/screens/profile.screen.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';

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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DietTrackMenuScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, isDarkMode, _) {
        return Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: Container(
            height: 80,
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: appcolorblack.withValues(alpha: 0.1),
                  blurRadius: 15,
                  spreadRadius: 3,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: isDarkMode
                    ? const Color.fromARGB(255, 37, 36, 36)
                    : appcolorwhite,
                selectedItemColor: appcolorRed,
                unselectedItemColor:
                    isDarkMode ? appcolorwhite : appcolorblack,
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
      },
    );
  }
}
 