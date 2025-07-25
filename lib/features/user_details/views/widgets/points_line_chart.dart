import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/custom_container.dart';
import 'package:urps_ordein/features/user_details/views/widgets/drop_down.dart';

class PointsLineChart extends StatelessWidget {
  const PointsLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "Total Point's",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      "6.5k",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                MyDropdown(),
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
                            getBottomTitles('day', value),
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
                      spots: const [
                        FlSpot(0, 10),
                        FlSpot(1, 30),
                        FlSpot(2, 18),
                        FlSpot(3, 35),
                        FlSpot(4, 12),
                        FlSpot(5, 6),
                        FlSpot(6, 14),
                      ],
                    ),
                    // Past data line
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 8),
                        FlSpot(1, 22),
                        FlSpot(2, 12),
                        FlSpot(3, 28),
                        FlSpot(4, 9),
                        FlSpot(5, 3),
                        FlSpot(6, 10),
                      ],
                      isCurved: true,
                      color: secondaryColor,
                      barWidth: 4,
                      dotData: FlDotData(show: false),
                      dashArray: [5, 5], // Dashed line for past
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getBottomTitles(String data, double value) {
  switch (data) {
    case 'day':
      return Text(
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][value.toInt() % 7],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: const Color.fromARGB(202, 72, 83, 111),
        ),
      );
    case 'week':
      return Text('W${(value + 1).toInt()}');
    case 'year':
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
      );
    default:
      return const Text('');
  }
}
