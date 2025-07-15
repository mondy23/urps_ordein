import 'package:flutter/material.dart';
import 'package:urps_ordein/models/todays_stats_model.dart';

class TodaysStatsDetails {
  final todaysStatsData = <TodaysStatsModel>[
    TodaysStatsModel(icon: Icons.people_rounded, title: 'New Users Today', value: 12, subvalue: 2),
    TodaysStatsModel(icon: Icons.transfer_within_a_station_rounded, title: 'Transactions Today', value: 98, subvalue: 3),
    TodaysStatsModel(icon: Icons.redeem_rounded, title: 'Redemptions Today', value: 21, subvalue: 8),
  ];
}
