import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/custom_level.dart';
import 'package:fit_form/Screens/Inside_Screens/add_workout_screen.dart';
import 'package:fit_form/features/calendar_events/widgets/customize_sliver_app_bar.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';

class CustomizeWorkoutScreen extends StatefulWidget {
  const CustomizeWorkoutScreen({super.key, this.id});
  final String? id;

  @override
  State<CustomizeWorkoutScreen> createState() => _CustomizeWorkoutScreenState();
}

class _CustomizeWorkoutScreenState extends State<CustomizeWorkoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String currentQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getWorkouts();
    _searchController.addListener(onSearchChanged);
  }

  void onSearchChanged() {
    setState(() => currentQuery = _searchController.text);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, isDarkMode, _) {
        return Scaffold(
          backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: appcolorRed,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, animation, __) => AddworkoutScreen(id: widget.id),
                  transitionsBuilder: (_, animation, __, child) =>
                      FadeTransition(opacity: animation, child: child),
                ),
              );
            },
            child: Icon(Icons.fitness_center_rounded, size: 30, color: appcolorwhite),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              CustomizeSliverAppBar(
                searchController: _searchController,
                tabController: _tabController,
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                BeginnerTabBar(currentQuery: currentQuery),
                IntermediateTabBar(currntQuery: currentQuery),
                AdvacedTabBar(currntQuery: currentQuery),
              ],
            ),
          ),
        );
      },
    );
  }
}
