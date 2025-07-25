class InfoModel {
  final String userID;
  final int businessID;
  final int totalPoints;
  final DateTime updatedAt;
  final DateTime createdAt;

  InfoModel({
    required this.userID,
    required this.businessID,
    required this.totalPoints,
    required this.updatedAt,
    required this.createdAt,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      userID: json['account_identifier'] as String? ?? '',
      businessID: json['primary_business_id'] as int? ?? 0,
      totalPoints: json['total_points'] as int? ?? 0,
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  factory InfoModel.empty() {
    return InfoModel(
      userID: '',
      businessID: 0,
      totalPoints: 0,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'account_identifier': userID,
        'primary_business_id': businessID,
        'total_points': totalPoints,
        'updated_at': updatedAt.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
      };
}
