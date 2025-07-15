import 'package:urps_ordein/models/points_logs_model.dart';

class PointLogsData {
  final data = [
    PointsLogsModel(
      type: 'Earned',
      points: 100,
      description: 'Referral bonus',
      refID: 'REF12345',
      time: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PointsLogsModel(
      type: 'Redeemed',
      points: -50,
      description: 'Used for discount',
      refID: 'SALE7890',
      time: DateTime.now().subtract(const Duration(days: 2)),
    ),
    PointsLogsModel(
      type: 'Bonus',
      points: 25,
      description: 'Birthday gift',
      refID: 'BIRTHDAY001',
      time: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];
}
