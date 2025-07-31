import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/features/user_details/models/info_model.dart';
import 'package:urps_ordein/features/user_details/models/points_line_chart.dart';
import 'package:urps_ordein/features/user_details/models/redemption_model.dart';
import 'package:urps_ordein/features/user_details/models/transaction_model.dart';
import 'package:urps_ordein/features/user_details/services/user_services.dart';



final userServiceProvider = Provider((ref) => UserServices());
final totalPointsProvider = StateProvider<int>((ref) => 0);

// User Details
final userDetailsProvider = FutureProvider.family<UserInfo?, (int businessID, String userID)>((ref, args) async {
  final service = ref.read(userServiceProvider);
  return service.getUserDetails(args.$1, args.$2); // (businessID, userID)
});

//Points Line Chart
final selectedTimeframeProvider = StateProvider<String>((ref) => 'Day');
final pointsLineChartProvider = FutureProvider.family<PointsLineChartResponse?, (int businessID, String userID)>((ref, args) async {
  final service = ref.read(userServiceProvider);          
  return service.getPointsLineChart(args.$1, args.$2);    
});

// Get Transactions
final getTransactions = FutureProvider.family<TransactionResponse?, (int page, int limit)>((ref, args) async {
  final service = ref.read(userServiceProvider);
  return service.getTransactions(args.$1, args.$2);
});

// Get Redemptions
final getRedemption = FutureProvider.family<RedemptionResponse?, (int page, int limit)>((ref, args) async {
  final service = ref.read(userServiceProvider);
  return service.getRedemptions(args.$1, args.$2);
});

