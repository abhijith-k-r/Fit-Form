// ignore_for_file: unused_field
import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/custom_level.dart';
import 'package:fit_form/Screens/Inside_Screens/add_workout_screen.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  List<WorkoutsModel> _filteredWorkouts = [];
  String currentQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    getWorkouts();
    _searchController.addListener(onSearchChanged);
    _filteredWorkouts = workoutsNotify.value;
  }

  onSearchChanged() {
    setState(() {
      currentQuery = _searchController.text;
      _filteredWorkouts = searchWorkouts(currentQuery);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: appcolorRed,
        onPressed: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddworkoutScreen(
                  id: widget.id,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ));
        },
        child: Icon(
          Icons.fitness_center_rounded,
          size: 30,
          color: appcolorwhite,
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            backgroundColor: appcolorblack,
            shadowColor: appcolorRed,
            expandedHeight: 300.0,
            pinned: true,
            floating: false,
            title: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [appcoloryellow, appcolorRed],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'Customize',
                style: GoogleFonts.jost(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: appcolorwhite),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'asset/Work_Outs_Images/DeadLiftAi.jpg',
                fit: BoxFit.cover,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(140.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Your Workouts',
                        hintStyle: TextStyle(color: appcolorRed),
                        prefixIcon: Icon(
                          Icons.search,
                          color: appcolorRed,
                        ),
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
                  TabBar(
                    controller: _tabController,
                    indicatorColor: appcolorRed,
                    labelColor: appcolorRed,
                    unselectedLabelColor: appcolorwhite,
                    labelStyle: GoogleFonts.jost(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(text: 'Beginner'),
                      Tab(text: 'Intermediate'),
                      Tab(text: 'Advanced'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            //! Beginner_Level_Workout >< <> >
            BeginnerTabBar(currentQuery: currentQuery),
            //! Intermediate_Level_Workout >< <> >
            IntermediateTabBar(currntQuery: currentQuery),
            //! Advanced_Level_Workout >< <> >
            AdvacedTabBar(currntQuery: currentQuery),
          ],
        ),
      ),
    );
  }
}
