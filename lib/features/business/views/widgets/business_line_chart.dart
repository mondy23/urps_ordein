import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/features/business/controllers/users_provider.dart';
import 'package:urps_ordein/features/business/model/business_linechart.dart';
import 'package:urps_ordein/features/user_details/views/widgets/drop_down.dart';
import 'package:urps_ordein/widgets/error_no_data.dart';

class BusinessLineChart extends ConsumerWidget {
  final int businessID;
  const BusinessLineChart({
    super.key,
    required this.businessID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lineChart = ref.watch(businessLineChartProvider((businessID)));
    final selectedTimeframe = ref.watch(selectedTimeframeProvider);
    return lineChart.when(
      data: (data) {
        if (data == null) {
          return ErrorNoData();
        }
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          height: 475,
          child: Stack(
            children: [
              Container(
                // padding: EdgeInsets.all(48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total Users",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Text(
                          formatPoints(data.totalUsers),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    MyDropdown(
                      value: selectedTimeframe,
                      onChanged: (String? newValue) {
                        print(newValue);
                        if (newValue != null) {
                          ref.read(selectedTimeframeProvider.notifier).state =
                              newValue;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  height: 330,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (touchedSpot) => backgroundColor,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((LineBarSpot spot) {
                              bool isEarned = spot.y.toInt() > 0;
                              return LineTooltipItem(
                                '${formatPoints(spot.y.toInt())} users',
                                TextStyle(
                                  color: isEarned ? primaryColor : textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) =>
                                getBottomTitles(selectedTimeframe, value),
                            reservedSize: 32,
                            interval: 1,
                          ),
                        ),
                      ),
                      // Present data line
                      lineBarsData: [
                        LineChartBarData(
                          preventCurveOverShooting: true,
                          isCurved: true,
                          barWidth: 4,
                          color: primaryColor,
                          spots: flspotForEarn(
                            data.timeframes,
                            selectedTimeframe,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stack) => Center(child: Text('No data found')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

Widget getBottomTitles(String data, double value) {
  switch (data) {
    case 'Day':
      return Text(
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][value.toInt() % 7],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: const Color.fromARGB(202, 72, 83, 111),
        ),
      );
    case 'Week':
      return Text(
        'W${(value + 1).toInt()}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: const Color.fromARGB(202, 72, 83, 111),
        ),
      );
    case 'Year':
      return Text(
        [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ][value.toInt() % 12],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: const Color.fromARGB(202, 72, 83, 111),
        ),
      );
    default:
      return const Text('');
  }
}

String formatPoints(int points) {
  if (points >= 1_000_000_000) {
    return '${(points / 1_000_000_000).toStringAsFixed(1)}B';
  } else if (points >= 1_000_000) {
    return '${(points / 1_000_000).toStringAsFixed(1)}M';
  } else if (points >= 1_000) {
    return '${(points / 1_000).toStringAsFixed(1)}K';
  } else {
    return points.toString();
  }
}

List<FlSpot> flspotForEarn(Timeframes data, String timeFrame) {
  switch (timeFrame) {
    case 'Day':
      return data.day
          .map((e) => FlSpot(e.day.toDouble(), e.users.toDouble()))
          .toList();
    case 'Week':
      return data.week
          .map((e) => FlSpot((e.week - 1).toDouble(), e.users.toDouble()))
          .toList();
    case 'Year':
      return data.year
          .map((e) => FlSpot((e.month - 1).toDouble(), e.users.toDouble()))
          .toList();
    default:
      return [];
  }
}


// List<FlSpot> flspotForRedeem(Timeframes data, String timeFrame) {
//   switch (timeFrame) {
//     case 'day':
//       return [
//         FlSpot(0, 8),
//         FlSpot(1, 22),
//         FlSpot(2, 12),
//         FlSpot(3, 28),
//         FlSpot(4, 9),
//         FlSpot(5, 3),
//         FlSpot(6, 10),
//       ];
//     case 'week':
//       return [
//         FlSpot(0, 12),
//         FlSpot(1, 20),
//         FlSpot(2, 16),
//         FlSpot(3, 24),
//         FlSpot(4, 8),
//       ];
//     case 'year':
//       return [
//         FlSpot(0, 5),
//         FlSpot(1, 12),
//         FlSpot(2, 10),
//         FlSpot(3, 18),
//         FlSpot(4, 9),
//         FlSpot(5, 4),
//         FlSpot(6, 11),
//         FlSpot(7, 17),
//         FlSpot(8, 14),
//         FlSpot(9, 19),
//         FlSpot(10, 8),
//         FlSpot(11, 13),
//       ];
//     default:
//       return [FlSpot(6, 10)];
//   }
// }
