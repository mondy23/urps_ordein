class RedemptionResponse {
  final int currentPage;
  final List<RedemptionModel> records;
  final int totalCount;
  final int totalPages;

  RedemptionResponse({
    required this.currentPage,
    required this.records,
    required this.totalCount,
    required this.totalPages,
  });

  factory RedemptionResponse.fromJson(Map<String, dynamic> json) {
    return RedemptionResponse(
      currentPage: json['currentPage'],
      records: (json['records'] as List)
          .map((e) => RedemptionModel.fromJson(e))
          .toList(),
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
    );
  }
}

class RedemptionModel {
  final String accountIdentifier;
  final int businessId;
  final int pointsRedeemed;
  final int redemptionId;
  final DateTime redemptionTime;

  RedemptionModel({
    required this.accountIdentifier,
    required this.businessId,
    required this.pointsRedeemed,
    required this.redemptionId,
    required this.redemptionTime,
  });

  factory RedemptionModel.fromJson(Map<String, dynamic> json) {
    return RedemptionModel(
      accountIdentifier: json['account_identifier'],
      businessId: json['business_id'],
      pointsRedeemed: json['points_redeemed'],
      redemptionId: json['redemption_id'],
      redemptionTime: DateTime.parse(json['redemption_time']),
    );
  }
}
