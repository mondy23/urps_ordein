import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urps_ordein/api/client.dart';
import 'package:urps_ordein/models/business_table_model.dart';
import 'package:urps_ordein/models/top_performing_businesses_model.dart';

class BusinessFetchResult {
  final List<BusinessTableModel> businesses;
  final List<TopPerformingBusinessesModel> topBusinesses;
  final int count;

  BusinessFetchResult({required this.businesses, required this.count, required this.topBusinesses});
}

class BusinessService {
  final _dio = DioClient().dio;

  Future<BusinessFetchResult> fetchBusinesses(int rowCount, page) async {
    try {
      final response = await _dio.get(
        '/businesses?page=$page&limit=$rowCount',
      ); // Fetch businesses with dynamic limit
      final List data = response.data['data']; // Extract business data
      final int count = response.data['totalbusiness'];
      final List top10 = response.data['top10'];

      return BusinessFetchResult(
      
        topBusinesses: top10.map((tb)=>TopPerformingBusinessesModel.fromMap(tb as Map<String, dynamic>)).toList(),
        businesses: data
            .map(
              (b) => BusinessTableModel.fromMap(b as Map<String, dynamic>),
            ) // Map to BusinessTableModel
            .toList(),
        count: count,
      );
    } catch (e) {
      throw Exception('Failed to fetch businesses: $e'); // Handle errors
    }
  }
}

final businessServiceProvider = Provider<BusinessService>((ref) {
  return BusinessService();
});

final rowCountProvider = StateProvider<int>((ref) => 5); // default minRowCount

final pageSelected = StateProvider<int>((ref) => 1);

final totalRowCount = StateProvider<int>((ref) => 0);

final businessesProvider = FutureProvider<BusinessFetchResult>((
  ref,
) async {
  final service = ref.watch(businessServiceProvider);
  final rowCount = ref.watch(rowCountProvider);
  final page = ref.watch(pageSelected);
  return service.fetchBusinesses(rowCount, page);
});
