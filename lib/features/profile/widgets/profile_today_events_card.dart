import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/features/calendar_events/data/calendar_data_source.dart';
import 'package:fit_form/models/events_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTodayEventsCard extends StatelessWidget {
  const ProfileTodayEventsCard({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final cardBg = isDarkMode
        ? const Color.fromARGB(255, 34, 34, 34)
        : const Color.fromARGB(255, 245, 245, 247);

    return ValueListenableBuilder<List<Events>>(
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
                    Icon(Icons.event_note, size: 20, color: appcolorRed),
                    const SizedBox(width: 8),
                    Text(
                      "Today's Events & Goals",
                      style: GoogleFonts.fredoka(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? appcolorwhite : appcolorblack,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: appcolorRed.withValues(alpha: 0.12),
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
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.event_available,
                            size: 22, color: Colors.grey[500]),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'No events scheduled for today',
                              style: GoogleFonts.jost(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDarkMode ? appcolorwhite : appcolorblack,
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
                color: cardBg,
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
                        backgroundColor: appcolorRed.withValues(alpha: 0.15),
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
                          color: isDarkMode ? appcolorwhite : appcolorblack,
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
    );
  }
}
