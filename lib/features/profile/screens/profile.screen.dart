import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/calendar_events/data/calendar_data_source.dart';
import 'package:fit_form/features/profile/widgets/profile_bmi_card.dart';
import 'package:fit_form/features/profile/widgets/profile_header_card.dart';
import 'package:fit_form/features/profile/widgets/profile_preferences_card.dart';
import 'package:fit_form/features/profile/widgets/profile_stats_row.dart';
import 'package:fit_form/features/profile/widgets/profile_today_events_card.dart';
import 'package:fit_form/functions/auth.dart';
import 'package:fit_form/main.dart';
import 'package:fit_form/models/usermodel.dart';
import 'package:flutter/material.dart';
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
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, isDarkMode, _) {
        return ValueListenableBuilder<List<Usermodel>>(
          valueListenable: userDatas,
          builder: (context, user, child) {
            if (user.isEmpty) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            final profile = user.firstWhere((e) => e.id == widget.id, orElse: () => user.first);

            return Scaffold(
              backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
              appBar: AppBar(
                backgroundColor: isDarkMode ? appcolorblack : appcolorwhite,
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  'My Profile',
                  style: GoogleFonts.fredoka(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? appcolorwhite : appcolorblack,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  children: [
                    ProfileHeaderCard(profile: profile, isDarkMode: isDarkMode),
                    const SizedBox(height: 20),
                    ProfileBmiCard(height: profile.height, weight: profile.weight, isDarkMode: isDarkMode),
                    const SizedBox(height: 14),
                    ProfileStatsRow(isDarkMode: isDarkMode),
                    const SizedBox(height: 20),
                    ProfileTodayEventsCard(isDarkMode: isDarkMode),
                    const SizedBox(height: 20),
                    ProfilePreferencesCard(userId: profile.id, isDarkMode: isDarkMode),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
