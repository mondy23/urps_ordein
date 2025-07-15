import 'package:flutter/material.dart';
import 'package:urps_ordein/widgets/dashboard_recent_activity_widget.dart';
import 'package:urps_ordein/widgets/quick_links_widget.dart';
import 'package:urps_ordein/pages/dashboard/widgets/system_summary_widget.dart';
import 'package:urps_ordein/pages/dashboard/widgets/table_top_performing_business_widget.dart';
import 'package:urps_ordein/pages/dashboard/widgets/card_todays_stats_widget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Main content area
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: const Column(
              children: [
                TodaysStatsCard(),
                Expanded(child: TableTopPerformingBusinessWidget()),
              ],
            ),
          ),
        ),

        // Sidebar widgets
        Expanded(
          flex: 4,
          child: const Column(
            children: [
              Expanded(flex: 3, child: QuickLinksWidget()),
              SizedBox(height: 2),
              Expanded(flex: 4, child: SystemSummaryWidget()),
              SizedBox(height: 2),
              Expanded(flex: 6, child: DashboardRecentActivityWidget()),
            ],
          ),
        ),
      ],
    );
  }
}
