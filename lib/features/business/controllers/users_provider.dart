import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/api/api.dart';
import 'package:urps_ordein/features/business/model/business_linechart.dart';
import 'package:urps_ordein/features/business/model/summary_model.dart';
import 'package:urps_ordein/features/business/model/user_model.dart';
import 'package:urps_ordein/features/business/services/business_services.dart';

final usersProvider = FutureProvider.family<List<UserModel>, int>((ref, businessID) async {
  final service = APIService<UserModel>(
    endpoint: "/api/private/v1/businesses/$businessID/users",
    fromJson: (json) => UserModel.fromJson(json),
    toJson: (model) => model.toJson(),
  );
  return service.getListAll(1, 100); // Get page 1, max 100 users (adjust as needed)
});

final businessSummaryProvider = FutureProvider.family<BusinessSummary, int>((ref, businessID) async {
  final service = APIService<BusinessSummary>(
    endpoint: "/api/private/v1/businesses/$businessID/summary",
    fromJson: (json) => BusinessSummary.fromJson(json),
    toJson: (model) => model.toJson(),
  );
  
  return service.get(); // Changed from getListAll to get
});

// Timeframe state (e.g., Day, Week, Year)
final selectedTimeframeProvider = StateProvider<String>((ref) => 'Day');

// Provide the BusinessServices instance
final businessServicesProvider = Provider<BusinessServices>((ref) => BusinessServices());

// Fetch Business Line Chart with businessID
final businessLineChartProvider = FutureProvider.family<BusinessUserLineChart?, int>((ref, businessID) async {
  final service = ref.read(businessServicesProvider);
  return service.getBusinessLineChart(businessID: businessID);
});


