class UserModel {
  final String accountIdentifier;
  final int totalPoints;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  UserModel({
    required this.accountIdentifier,
    required this.totalPoints,
    required this.updatedAt,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accountIdentifier: json['account_identifier'] ?? '',
      totalPoints: json['total_points'] ?? 0,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'account_identifier': accountIdentifier,
        'total_points': totalPoints,
        'updated_at': updatedAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
      };
}
