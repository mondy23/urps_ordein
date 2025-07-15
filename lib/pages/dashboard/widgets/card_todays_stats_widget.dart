import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:urps_ordein/api/urps_websocket_provider.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/data/todays_stats_data.dart';
import 'package:urps_ordein/models/urps_websocket_model.dart';

class TodaysStatsCard extends ConsumerWidget {
  const TodaysStatsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todaysStatsDetails = TodaysStatsDetails();
    final summary = ref.watch(systemSummaryProvider);

    if (summary == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      itemCount: todaysStatsDetails.todaysStatsData.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        mainAxisExtent: 150,
      ),
      itemBuilder: (context, index) => customCard(summary, todaysStatsDetails, index),
    );
  }

  Widget customCard(SystemSummaryModels? todaystats, TodaysStatsDetails data, int index) {
    data.todaysStatsData[0].value = todaystats?.newUsers ?? 0;
    data.todaysStatsData[1].value = todaystats?.totalTransactionsToday ?? 0;
    data.todaysStatsData[2].value = todaystats?.totalRedemptionsToday ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 18),
                child: Text(
                  data.todaysStatsData[index].title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 16),
                child: Icon(
                  data.todaysStatsData[index].icon,
                  size: 32,
                  color: textColor,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  NumberFormat('#,###').format(data.todaysStatsData[index].value),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Text(
              //   ' +${data.todaysStatsData[index].subvalue}',
              //   style: TextStyle(
              //     color: primaryColor,
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
