class ActivityModel {
  final String action;
  final String user;
  final String business;
  final String time;

  ActivityModel({
    required this.action,
    required this.user,
    required this.business,
    required this.time,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      action: json['action_log'] ?? '',
      user: json['fullname'] ?? '',
      business: json['business'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action_log': action,
      'fullname': user,
      'business': business,
      'time': time,
    };
  }
}
