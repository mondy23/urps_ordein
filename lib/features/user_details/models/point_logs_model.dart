class PointLogModels {
  final int pointLogID;
  final String accountIdentifier;
  final int points;
  final String type;
  final DateTime timestamp;

  PointLogModels({
    required this.pointLogID,
    required this.accountIdentifier,
    required this.points,
    required this.type,
    required this.timestamp,
  });

  factory PointLogModels.fromJson(Map<String, dynamic> json) {
    return PointLogModels(
      pointLogID: json['pointLog_id'] as int? ?? 0,
      accountIdentifier: json['account_identifier'] as String? ?? '',
      points: json['points'] as int? ?? 0,
      type: json['type'] as String? ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'pointLog_id': pointLogID,
        'account_identifier': accountIdentifier,
        'points': points,
        'type': type,
        'timestamp': timestamp.toIso8601String(),
      };
}

class PointLogsResponse {
  final int pointLogCount;
  final List<PointLogModels> pointLogs;

  PointLogsResponse({
    required this.pointLogCount,
    required this.pointLogs,
  });

  factory PointLogsResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PointLogsResponse.empty();

    final logs = json['logs'];
    return PointLogsResponse(
      pointLogCount: json['total'] as int? ?? 0,
      pointLogs: logs is List
          ? logs.map((p) => PointLogModels.fromJson(p)).toList()
          : [],
    );
  }

  factory PointLogsResponse.empty() {
    return PointLogsResponse(
      pointLogCount: 0,
      pointLogs: [],
    );
  }
}
