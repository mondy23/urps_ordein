import 'package:urps_ordein/features/user_details/models/info_model.dart';
import 'package:urps_ordein/features/user_details/models/point_logs_model.dart';
import 'package:urps_ordein/features/user_details/models/redemption_model.dart';
import 'package:urps_ordein/features/user_details/models/transaction_model.dart';

class UserDetailsResponseModel {
  final InfoModel userInfo;
  final PointLogsResponse pointLogs;
  final TransactionResponse transaction;
  final RedemptionResponse redemption;

  UserDetailsResponseModel({
    required this.userInfo,
    required this.pointLogs,
    required this.transaction,
    required this.redemption,
  });

  factory UserDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponseModel(
      userInfo: json['info'] != null
          ? InfoModel.fromJson(json['info'] as Map<String, dynamic>)
          : InfoModel.empty(),
      pointLogs: json['point_logs'] != null
          ? PointLogsResponse.fromJson(json['point_logs'] as Map<String, dynamic>)
          : PointLogsResponse.empty(),
      transaction: json['transaction'] != null
          ? TransactionResponse.fromJson(json['transaction'] as Map<String, dynamic>)
          : TransactionResponse.empty(),
      redemption: json['redemption'] != null
          ? RedemptionResponse.fromJson(json['redemption'] as Map<String, dynamic>)
          : RedemptionResponse.empty(),
    );
  }
}
