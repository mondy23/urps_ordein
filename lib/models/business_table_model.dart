// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BusinessTableModel {
  final String businessName;
  final String industry;
  final DateTime createdAt;
  final int totalUsers;
  final int pointsReleased;
  final int pointsRedeemed;

  BusinessTableModel({
    required this.businessName,
    required this.industry,
    required this.createdAt,
    required this.totalUsers,
    required this.pointsReleased,
    required this.pointsRedeemed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'businessName': businessName,
      'industry': industry,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'totalUsers': totalUsers,
      'pointsReleased': pointsReleased,
      'pointsRedeemed': pointsRedeemed,
    };
  }

  factory BusinessTableModel.fromMap(Map<String, dynamic> map) {
  return BusinessTableModel(
    businessName: map['name'],
    industry: map['industry'],
    createdAt: DateTime.parse(map['created_at']),
    totalUsers: map['total_users'],
    pointsReleased: map['points_released'],
    pointsRedeemed: map['points_redeem'],
  );
}

  String toJson() => json.encode(toMap());

  factory BusinessTableModel.fromJson(String source) => BusinessTableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
