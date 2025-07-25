class RedemptionModel {
  final int redemptionID;
  final String accountIdentifier;
  final String reward;
  final DateTime redemptionTime;

  RedemptionModel({
    required this.redemptionID,
    required this.accountIdentifier,
    required this.reward,
    required this.redemptionTime,
  });

  factory RedemptionModel.fromJson(Map<String, dynamic> json) {
    return RedemptionModel(
      redemptionID: json['redemption_id'] as int? ?? 0,
      accountIdentifier: json['account_identifier'] as String? ?? '',
      reward: json['reward'] as String? ?? '',
      redemptionTime: DateTime.tryParse(json['redemption_time'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'redemption_id': redemptionID,
        'account_identifier': accountIdentifier,
        'reward': reward,
        'redemption_time': redemptionTime.toIso8601String(),
      };
}

class RedemptionResponse {
  final int redemptionCount;
  final List<RedemptionModel> redemptions;

  RedemptionResponse({
    required this.redemptionCount,
    required this.redemptions,
  });

  factory RedemptionResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return RedemptionResponse.empty();

    final redemptionsList = json['redemptions'];
    return RedemptionResponse(
      redemptionCount: json['total'] as int? ?? 0,
      redemptions: redemptionsList is List
          ? redemptionsList.map((r) => RedemptionModel.fromJson(r)).toList()
          : [],
    );
  }

  factory RedemptionResponse.empty() {
    return RedemptionResponse(
      redemptionCount: 0,
      redemptions: [],
    );
  }
}
