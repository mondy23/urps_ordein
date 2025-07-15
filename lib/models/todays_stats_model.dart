import 'package:flutter/widgets.dart';

class TodaysStatsModel {
  final IconData icon;
  final String title;
  int value;
  final int subvalue;

  TodaysStatsModel({
    required this.icon,
    required this.title,
    required this.value,
    required this.subvalue,
  });
}
