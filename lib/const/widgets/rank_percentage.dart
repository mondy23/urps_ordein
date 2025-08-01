import 'package:urps_ordein/features/user_details/views/widgets/circle_percent.dart';

class RankProgress {
  final String currentRank;
  final int currentThreshold;
  final int nextThreshold;
  final double percent;

  RankProgress({
    required this.currentRank,
    required this.currentThreshold,
    required this.nextThreshold,
    required this.percent,
  });
}

RankProgress calculateRankProgress(int totalPoints) {
  final rankThresholds = {
    'Bronze': 0,
    'Silver': 100,
    'Gold': 1000,
    'Platinum': 3000,
    'Diamond': 5000,
  };

  final currentRank = getRank(totalPoints);
  final ranks = rankThresholds.entries.toList()
    ..sort((a, b) => a.value.compareTo(b.value));

  int currentThreshold = 0;
  int nextThreshold = 5000;

  for (int i = 0; i < ranks.length; i++) {
    if (ranks[i].key == currentRank) {
      currentThreshold = ranks[i].value;
      nextThreshold = (i + 1 < ranks.length) ? ranks[i + 1].value : currentThreshold;
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

  return RankProgress(
    currentRank: currentRank,
    currentThreshold: currentThreshold,
    nextThreshold: nextThreshold,
    percent: targetPercentage,
  );
}
