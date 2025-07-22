class BusinessModel {
  final int? businessID;
  final String? businessName;
  final String? industry;
  final int totalUsers;
  final int pointsReleased;
  final int pointsRedeemed;
  final DateTime? createdAt;

  BusinessModel({
    this.businessID,
    this.businessName,
    this.industry,
    this.createdAt,
    this.totalUsers = 0,
    this.pointsReleased = 0,
    this.pointsRedeemed = 0,
  });

 factory BusinessModel.fromJson(Map<String, dynamic> json) {
  return BusinessModel(
    businessID: json['business_id'] as int?,
    businessName: json['name'] as String?,
    industry: json['industry'] as String?,
    totalUsers: json['total_users'] ?? 0,
    pointsReleased: json['points_released'] ?? 0,
    pointsRedeemed: json['points_redeem'] ?? 0,
    createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
  );
}

Map<String, dynamic> toJson() {
  return {
    'business_id': businessID,
    'name': businessName,
    'industry': industry,
    'total_users': totalUsers,
    'points_released': pointsReleased,
    'points_redeem': pointsRedeemed,
    'created_at': createdAt?.toIso8601String(),
  };
}

}
