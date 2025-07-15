import 'package:urps_ordein/models/recent_activity.dart';

class SystemSummaryModels {
  final int totalBusinesses;
  final int totalUsers;
  final int totalPointsIssued;
  final int totalPointsRedeemed;
  final int totalActive;
  final int newUsers;
  final int totalTransactionsToday;
  final int totalRedemptionsToday;
  final List<ActivityModel> recentActivities;

  SystemSummaryModels({
    required this.totalBusinesses,
    required this.totalUsers,
    required this.totalPointsIssued,
    required this.totalPointsRedeemed,
    required this.totalActive,
    required this.newUsers,
    required this.totalTransactionsToday,
    required this.totalRedemptionsToday,
    required this.recentActivities,
  });

  factory SystemSummaryModels.fromJson(Map<String, dynamic> json) {
    final system = json['SystemSummary'] ?? {};
    final today = json['TodayStatus'] ?? {};
    final recentAct = json['RecentActivity'] as List<dynamic>? ?? [];

    return SystemSummaryModels(
      totalBusinesses: system['total_businesses'] ?? 0,
      totalUsers: system['total_users'] ?? 0,
      totalPointsIssued: (system['total_points_issued'] ?? 0).toDouble(),
      totalPointsRedeemed: (system['total_points_redeemed'] ?? 0).toDouble(),
      totalActive: system['total_active_api_key'] ?? 0,
      newUsers: today['new_users_today'] ?? 0,
      totalTransactionsToday: today['transactions_today'] ?? 0,
      totalRedemptionsToday: today['redemptions_today'] ?? 0,
      recentActivities: recentAct
          .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SystemSummary': {
        'total_businesses': totalBusinesses,
        'total_users': totalUsers,
        'total_points_issued': totalPointsIssued,
        'total_points_redeemed': totalPointsRedeemed,
        'total_active_api_key': totalActive,
      },
      'TodayStatus': {
        'new_users_today': newUsers,
        'transactions_today': totalTransactionsToday,
        'redemptions_today': totalRedemptionsToday,
      },
      'RecentActivity': recentActivities.map((e) => e.toJson()).toList(),
    };
  }
}
