import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/api/urps_websocket_provider.dart';
import 'package:urps_ordein/const/constant.dart';

class DashboardRecentActivityWidget extends ConsumerWidget {
  const DashboardRecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(systemSummaryProvider);

    final activities = summary?.recentActivities ?? [];

    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: textColor, size: 28),
                SizedBox(width: 8),
                Text(
                  'Recent Activity',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 🛑 Replace Expanded with Flexible if parent doesn't constrain height
          Expanded(
            child: activities.isEmpty
                ? Center(
                    child: Text(
                      'No recent activity',
                      style: TextStyle(color: textColor),
                    ),
                  )
                : ListView.builder(
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final activity = activities[index];

                      Color actionColor;
                      if (activity.action.toLowerCase().contains('earn')) {
                        actionColor = primaryColor;
                      } else if (activity.action.toLowerCase().contains('redeem')) {
                        actionColor = Colors.red;
                      } else {
                        actionColor = Colors.blueGrey;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activity.action,
                                  style: TextStyle(color: actionColor, fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  activity.user,
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  activity.business,
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 110, 112, 115),
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                activity.time,
                                style: TextStyle(color: textColor, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
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
    );
  }
}
