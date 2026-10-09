import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/Screens/Extracted_Screens/user_details.dart';
import 'package:fit_form/Screens/Inside_Screens/favorite_screen.dart';
import 'package:fit_form/Screens/Inside_Screens/settings.dart';
import 'package:fit_form/core/services/fitness_summary_service.dart';
import 'package:fit_form/features/diet_planner/data/healthy_diet_data_source.dart';
import 'package:fit_form/features/profile/screens/edit_profile.dart';
import 'package:fit_form/features/workouts/data/completed_workout_data_source.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:fit_form/features/calendar_events/data/calendar_data_source.dart';
import 'package:fit_form/models/events_modal.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.id});

  final String? id;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getData();
    CalendarDataSource.loadTodayEvents();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ValueListenableBuilder<List<Usermodel>>(
      valueListenable: userDatas,
      builder: (context, user, child) {
        if (user.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final profile = user.firstWhere(
          (elemnt) => elemnt.id == widget.id,
          orElse: () => user.first,
        );

        final bmi = FitnessSummaryService.calculateBmi(
          profile.height,
          profile.weight,
        );
        final bmiCategory = FitnessSummaryService.getBmiCategory(bmi);
        final bmiColor = FitnessSummaryService.getBmiColor(bmi);
        final isDarkMode = isDark.value;

        return Scaffold(
          backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
          appBar: AppBar(
            backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
            elevation: 0,
            title: Text(
              'My Profile',
              style: GoogleFonts.fredoka(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? appcolorwhite : appcolorblack,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, anim, secAnim) =>
                          EditProfile(id: profile.id),
                      transitionsBuilder: (_, anim, secAnim, child) =>
                          FadeTransition(opacity: anim, child: child),
                    ),
                  );
                },
                icon: Icon(Icons.edit_note, color: appcolorRed, size: 28),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Avatar & Name
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundColor: appcolorRed.withOpacity(0.15),
                        radius: screenWidth * 0.16,
                        backgroundImage: profile.imagePath != null &&
                                File(profile.imagePath!).existsSync()
                            ? FileImage(File(profile.imagePath!))
                            : null,
                        child: (profile.imagePath == null ||
                                !File(profile.imagePath!).existsSync())
                            ? Icon(
                                Icons.person,
                                size: screenWidth * 0.18,
                                color: appcolorRed,
                              )
                            : null,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProfile(id: profile.id),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: appcolorRed,
                          child: const Icon(Icons.edit,
                              size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.fullName?.isNotEmpty == true
                      ? profile.fullName!
                      : 'Fitness Champ',
                  style: GoogleFonts.fredoka(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? appcolorwhite : appcolorblack,
                  ),
                ),
                const SizedBox(height: 16),

                // User details: Height, Age, Weight
                UserDetails(id: profile.id),
                const SizedBox(height: 20),

                // BMI Status Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromARGB(255, 34, 34, 34)
                        : const Color.fromARGB(255, 245, 245, 247),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: bmiColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current BMI',
                              style: GoogleFonts.jost(
                                fontSize: 14,
                                color: isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              bmi != null
                                  ? bmi.toStringAsFixed(1)
                                  : 'Enter Height & Weight',
                              style: GoogleFonts.fredoka(
                                fontSize: bmi != null ? 22 : 16,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? appcolorwhite : appcolorblack,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: bmiColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          bmiCategory,
                          style: GoogleFonts.jost(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: bmiColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Today's Calories & Completed Workouts Cards
                Row(
                  children: [
                    // Today's Calories
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: healthyDietNotifier,
                        builder: (context, _, __) {
                          final todayCals =
                              FitnessSummaryService.getTodayDietCalories();
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? const Color.fromARGB(255, 34, 34, 34)
                                  : const Color.fromARGB(255, 245, 245, 247),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.local_fire_department,
                                        size: 20, color: appcolorRed),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Today's Calories",
                                      style: GoogleFonts.jost(
                                        fontSize: 12,
                                        color: isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${todayCals.toStringAsFixed(0)} kcal',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? appcolorwhite
                                        : appcolorblack,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Today's Workouts Done
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: completedWorkoutNotifier,
                        builder: (context, _, __) {
                          final stats =
                              FitnessSummaryService.getTodayWorkoutStats();
                          final totalDone = stats['Total'] ?? 0;

                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? const Color.fromARGB(255, 34, 34, 34)
                                  : const Color.fromARGB(255, 245, 245, 247),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.fitness_center,
                                        size: 18, color: appcolorgreen),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Workouts Done',
                                      style: GoogleFonts.jost(
                                        fontSize: 12,
                                        color: isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '$totalDone Completed',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? appcolorwhite
                                        : appcolorblack,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Today's Calendar Events Section
                ValueListenableBuilder<List<Events>>(
                  valueListenable: todayEventsNotifier,
                  builder: (context, todayEvents, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.event_note,
                                    size: 20, color: appcolorRed),
                                const SizedBox(width: 8),
                                Text(
                                  "Today's Events & Goals",
                                  style: GoogleFonts.fredoka(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkMode
                                        ? appcolorwhite
                                        : appcolorblack,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: appcolorRed.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${todayEvents.length} today',
                                style: GoogleFonts.jost(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: appcolorRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (todayEvents.isEmpty)
                          Material(
                            color: isDarkMode
                                ? const Color.fromARGB(255, 34, 34, 34)
                                : const Color.fromARGB(255, 245, 245, 247),
                            borderRadius: BorderRadius.circular(18),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 16),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.grey[800]
                                          : Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.event_available,
                                        size: 22, color: Colors.grey[500]),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'No events scheduled for today',
                                          style: GoogleFonts.jost(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: isDarkMode
                                                ? appcolorwhite
                                                : appcolorblack,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Add events in Calendar to track them here',
                                          style: GoogleFonts.jost(
                                            fontSize: 12,
                                            color: isDarkMode
                                                ? Colors.grey[400]
                                                : Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          Material(
                            color: isDarkMode
                                ? const Color.fromARGB(255, 34, 34, 34)
                                : const Color.fromARGB(255, 245, 245, 247),
                            borderRadius: BorderRadius.circular(20),
                            clipBehavior: Clip.antiAlias,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: todayEvents.length,
                              separatorBuilder: (_, __) => const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                              ),
                              itemBuilder: (context, index) {
                                final event = todayEvents[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        appcolorRed.withOpacity(0.15),
                                    radius: 18,
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      color: appcolorRed,
                                      size: 20,
                                    ),
                                  ),
                                  title: Text(
                                    event.title ?? 'Goal',
                                    style: GoogleFonts.jost(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? appcolorwhite
                                          : appcolorblack,
                                    ),
                                  ),
                                  subtitle: event.contents?.isNotEmpty == true
                                      ? Text(
                                          event.contents!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.jost(
                                            fontSize: 12,
                                            color: isDarkMode
                                                ? Colors.grey[400]
                                                : Colors.grey[600],
                                          ),
                                        )
                                      : null,
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Settings & Preferences List (wrapped in Material to fix DecoratedBox/ListTile assertion)
                Material(
                  color: isDarkMode
                      ? const Color.fromARGB(255, 34, 34, 34)
                      : const Color.fromARGB(255, 245, 245, 247),
                  borderRadius: BorderRadius.circular(22),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, anim, secAnim) =>
                                  EditProfile(id: profile.id),
                              transitionsBuilder: (_, anim, secAnim, child) =>
                                  FadeTransition(opacity: anim, child: child),
                            ),
                          );
                        },
                        leading: Icon(Icons.edit_square,
                            color: appcolorRed, size: 22),
                        title: Text(
                          'Edit Profile',
                          style: GoogleFonts.jost(
                            fontSize: 16,
                            color: isDarkMode ? appcolorwhite : appcolorblack,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, anim, secAnim) =>
                                  const FavoriteScreen(),
                              transitionsBuilder: (_, anim, secAnim, child) =>
                                  FadeTransition(opacity: anim, child: child),
                            ),
                          );
                        },
                        leading: Icon(Icons.favorite_outline_sharp,
                            color: appcolorRed, size: 22),
                        title: Text(
                          'Favorite Workouts',
                          style: GoogleFonts.jost(
                            fontSize: 16,
                            color: isDarkMode ? appcolorwhite : appcolorblack,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, anim, secAnim) =>
                                  const SettingsScreen(),
                              transitionsBuilder: (_, anim, secAnim, child) =>
                                  FadeTransition(opacity: anim, child: child),
                            ),
                          );
                        },
                        leading: Icon(Icons.settings,
                            color: appcolorRed, size: 22),
                        title: Text(
                          'Settings',
                          style: GoogleFonts.jost(
                            fontSize: 16,
                            color: isDarkMode ? appcolorwhite : appcolorblack,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        leading: Icon(Icons.dark_mode_outlined,
                            color: appcolorRed, size: 22),
                        title: Text(
                          'Dark Mode',
                          style: GoogleFonts.jost(
                            fontSize: 16,
                            color: isDarkMode ? appcolorwhite : appcolorblack,
                          ),
                        ),
                        trailing: Switch(
                          value: isDark.value,
                          activeThumbColor: appcolorRed,
                          onChanged: (value) {
                            setState(() {
                              isDark.value = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
