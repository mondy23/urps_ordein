import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/data/dashboard_recent_activity_data.dart';

class DashboardRecentActivityWidget extends StatefulWidget {
  const DashboardRecentActivityWidget({super.key});

  @override
  State<DashboardRecentActivityWidget> createState() => _DashboardRecentActivityWidgetState();
}

class _DashboardRecentActivityWidgetState extends State<DashboardRecentActivityWidget> {
  @override
  Widget build(BuildContext context) {
    final details = DashboardRecentActivityData();
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

          Expanded(
            child: ListView.builder(
              itemCount: details.data.length,
              itemBuilder: (context, index) {
                Color actionColor;
                if (details.data[index].action.toLowerCase().contains('points') && !(details.data[index].action.toLowerCase().contains('redeemed'))) {
                  actionColor = primaryColor;
                } else if (details.data[index].action.toLowerCase().contains('redeemed')) {
                  actionColor = Colors.red;
                } else {
                  actionColor = Colors.blueGrey;
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            details.data[index].action,
                            style: TextStyle(color: actionColor, fontSize: 12), // if contain points make it green and if redeem make it red else make it
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            details.data[index].user,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            details.data[index].business,
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
                          details.data[index].time,
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
