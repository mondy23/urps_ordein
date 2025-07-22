import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/features/business/api.dart';
import 'package:urps_ordein/features/business/model/business_model.dart';

// UI State
final pageSelectedProvider = StateProvider<int>((ref) => 1);
final rowCountProvider = StateProvider<int>((ref) => 10);
final totalBusinessCountProvider = StateProvider<int>((ref) => 0);

// API Providers

/// Fetch all businesses with pagination
final businessListProvider = FutureProvider<List<BusinessModel>>((ref) async {
  final page = ref.watch(pageSelectedProvider);
  final limit = ref.watch(rowCountProvider);

  final response = await businessCrudService.getPaginatedRaw(page, limit);

  // Set the total count in another provider
  ref.read(totalBusinessCountProvider.notifier).state = response['total'] ?? 0;

  final List<dynamic> rawList = response['data'] as List<dynamic>;
  return rawList.map((json) => BusinessModel.fromJson(json)).toList();
});


/// Create a new business
final createBusinessProvider = FutureProvider.family<BusinessModel, BusinessModel>(
  (ref, newBusiness) async {
    return businessCrudService.create(newBusiness);
  },
);
