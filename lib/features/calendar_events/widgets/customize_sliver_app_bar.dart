import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomizeSliverAppBar extends StatelessWidget {
  const CustomizeSliverAppBar({
    super.key,
    required this.searchController,
    required this.tabController,
  });

  final TextEditingController searchController;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
            color: appcolorwhite,
          ),
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
                controller: searchController,
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
            TabBar(
              controller: tabController,
              indicatorColor: appcolorRed,
              labelColor: appcolorRed,
              unselectedLabelColor: appcolorwhite,
              labelStyle:
                  GoogleFonts.jost(fontSize: 15, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'Beginner'),
                Tab(text: 'Intermediate'),
                Tab(text: 'Advanced'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
