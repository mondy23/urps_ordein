class TopPerformingBusinessesModel {
  final String businessName;
  final int pointsIssued;
  final int users;

  TopPerformingBusinessesModel({
    required this.businessName,
    required this.pointsIssued,
    required this.users,
  });

   factory TopPerformingBusinessesModel.fromMap(Map<String, dynamic> map) {
  return TopPerformingBusinessesModel(
    businessName: map['name'],
    users: map['total_users'],
    pointsIssued: map['points_released'],
  );
}
}
