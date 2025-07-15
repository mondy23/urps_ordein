class DashboardRecentActivityModel {
  final String action;
  final String user;
  final String business;
  final String time;

  DashboardRecentActivityModel({
    required this.action,
    required this.user,
    required this.business,
    required this.time,
  });

    factory DashboardRecentActivityModel.fromMap(Map<String, dynamic> map) {
  return DashboardRecentActivityModel(
    action: map['action_log'],
    user: map['fullname'],
    business: map['business'],
    time: map['time'],
  );
}

 factory DashboardRecentActivityModel.fromJson(Map<String, dynamic> json) {
    final recentActivity = json['RecentActivity'] ?? {};

    return DashboardRecentActivityModel(
      action: recentActivity['action_log'],
    user: recentActivity['fullname'],
    business: recentActivity['business'],
    time: recentActivity['time'],
    );
  }
}
