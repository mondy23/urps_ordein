import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/const/widgets/custom_container.dart';
import 'package:urps_ordein/features/user_details/controllers/user_controller.dart';

class CirclePercent extends ConsumerWidget {
  const CirclePercent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankThresholds = {
      'Bronze': 0,
      'Silver': 100,
      'Gold': 1000,
      'Platinum': 3000,
      'Diamond': 5000,
    };

    final totalPoints = ref.watch(totalPointsProvider);
    final currentRank = getRank(totalPoints);

    final ranks = rankThresholds.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    int currentThreshold = 0;
    int nextThreshold = 5000;

    for (int i = 0; i < ranks.length; i++) {
      if (ranks[i].key == currentRank) {
        currentThreshold = ranks[i].value;
        nextThreshold = (i + 1 < ranks.length)
            ? ranks[i + 1].value
            : currentThreshold;
        break;
      }
    }

    final pointsInCurrentRank = totalPoints - currentThreshold;
    final pointsNeeded = nextThreshold - currentThreshold;
    final targetPercentage = pointsNeeded == 0
        ? 100.0
        : (pointsInCurrentRank / pointsNeeded * 100)
            .clamp(0, 100)
            .toDouble();

    return CustomContainer(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: targetPercentage),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        builder: (context, animatedPercent, _) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 32,
                  left: 32,
                  child: Text(
                    currentRank,
                    style: const TextStyle(
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
                        value: animatedPercent,
                        color: primaryColor,
                        radius: 20,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 100 - animatedPercent,
                        color: Colors.grey.shade300,
                        radius: 20,
                        showTitle: false,
                      ),
                    ],
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 500),
                  swapAnimationCurve: Curves.easeInOut,
                ),
                Text(
                  "${animatedPercent.toInt()}%",
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String getRank(int totalPoints) {
  if (totalPoints >= 5000) return 'Diamond';
  if (totalPoints >= 3000) return 'Platinum';
  if (totalPoints >= 1000) return 'Gold';
  if (totalPoints >= 100) return 'Silver';
  return 'Bronze';
}
