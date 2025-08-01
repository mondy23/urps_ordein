import 'package:dio/dio.dart';
import 'package:urps_ordein/api/client.dart';
import 'package:urps_ordein/features/business/model/business_linechart.dart';

class BusinessServices {
  final Dio _dio = DioClient.instance;

  Future<BusinessUserLineChart?> getBusinessLineChart({
    required int businessID,
  }) async {
    try {
      final response = await _dio.get(
        '/api/private/v1/businesses/$businessID/linechart',
      );

      final data = response.data as Map<String, dynamic>;
      return BusinessUserLineChart.fromJson(data);
    } on DioException catch (e) {
      // Dio-specific error handling
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      // Unexpected errors
      print('Unexpected error: $e');
      return null;
    }
  }
}
