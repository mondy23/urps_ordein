class PointsLogsModel {
  final String type;
  final int points;
  final String description;
  final String refID;
  final DateTime time;

  PointsLogsModel({
    required this.type,
    required this.points,
    required this.description,
    required this.refID,
    required this.time,
  });
}
