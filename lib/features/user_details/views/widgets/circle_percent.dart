import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/custom_container.dart';

class CirclePercent extends StatelessWidget {
  final double percentage = 70;
  const CirclePercent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 32,
              left: 32,
              child: Text(
                'Silver',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            PieChart(
              PieChartData(
                startDegreeOffset: -90,
                sectionsSpace: 0,
                centerSpaceRadius: 80,
                sections: [
                  PieChartSectionData(
                    value: percentage,
                    color: primaryColor,
                    radius: 20,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 100 - percentage,
                    color: Colors.grey.shade300,
                    radius: 20,
                    showTitle: false,
                  ),
                ],
              ),
            ),
            Text(
              "${percentage.toInt()}%",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
