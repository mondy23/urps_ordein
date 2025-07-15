class SystemSummaryModels {
  final int totalBusinesses;
  final int totalUsers;
  final double totalPointsIssued;
  final double totalPointsRedeemed;
  final int totalActive;
  final int newUsers;
  final int totalTransactionsToday;
  final int totalRedemptionsToday;

  SystemSummaryModels({
    required this.totalBusinesses,
    required this.totalUsers,
    required this.totalPointsIssued,
    required this.totalPointsRedeemed,
    required this.totalActive,
    required this.newUsers,
    required this.totalTransactionsToday,
    required this.totalRedemptionsToday,
  });

  factory SystemSummaryModels.fromJson(Map<String, dynamic> json) {
    final system = json['SystemSummary'] ?? {};
    final today = json['TodayStatus'] ?? {};

    return SystemSummaryModels(
      totalBusinesses: system['total_businesses'] ?? 0,
      totalUsers: system['total_users'] ?? 0,
      totalPointsIssued: (system['total_points_issued'] ?? 0).toDouble(),
      totalPointsRedeemed: (system['total_points_redeemed'] ?? 0).toDouble(),
      totalActive: system['total_active_api_key'] ?? 0,
      newUsers: today['new_users_today'] ?? 0,
      totalTransactionsToday: today['transactions_today'] ?? 0,
      totalRedemptionsToday: today['redemptions_today'] ?? 0,
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
      }
    };
  }
}
