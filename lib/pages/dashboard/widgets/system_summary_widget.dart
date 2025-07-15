import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/api/business_api_provider.dart';
import 'package:urps_ordein/api/urps_websocket_provider.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/data/system_summary_data.dart';
import 'package:urps_ordein/models/urps_websocket_model.dart';

class SystemSummaryWidget extends ConsumerWidget {
  const SystemSummaryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessesAsync = ref.watch(businessesProvider);
    final summary = ref.watch(systemSummaryProvider);

    if (summary == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return businessesAsync.when(
      data: (data) => systemSummary(summary),
      error: (error, stack) => Center(child: Text('❌ Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

Widget systemSummary(SystemSummaryModels summary) {
  final details = SystemSummaryData();

  // Fill in the values from summary
  details.data[0].value = summary.totalBusinesses.toString();
  details.data[1].value = summary.totalUsers.toString();
  details.data[2].value = summary.totalPointsIssued.toStringAsFixed(2);
  details.data[3].value = summary.totalPointsRedeemed.toStringAsFixed(2);
  details.data[4].value = summary.totalActive.toString();

  return Container(
    decoration: BoxDecoration(color: cardBackgroundColor),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Row(
            children: [
              Icon(Icons.bar_chart, color: textColor, size: 28),
              const SizedBox(width: 8),
              Text(
                'System Summary',
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
              return Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Row(
                  children: [
                    Text(
                      details.data[index].title,
                      style: TextStyle(color: primaryColor),
                    ),
                    const Spacer(),
                    Text(
                      details.data[index].value,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
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
