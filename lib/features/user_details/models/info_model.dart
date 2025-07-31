class UserInfo {
  final String accountIdentifier;
  final String businessId;
  final int totalPoints;
  final String businessName;
  final String businessIndustry;
  final DateTime updatedAt;
  final DateTime createdAt;

  UserInfo({
    required this.accountIdentifier,
    required this.businessId,
    required this.totalPoints,
    required this.businessName,
    required this.businessIndustry,
    required this.updatedAt,
    required this.createdAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      accountIdentifier: json['account_identifier'],
      businessId: json['business_id'],
      totalPoints: json['total_points'],
      businessName: json['business_name'],
      businessIndustry: json['business_industry'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_identifier': accountIdentifier,
      'business_id': businessId,
      'total_points': totalPoints,
      'business_name': businessName,
      'business_industry': businessIndustry,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
