import 'package:dio/dio.dart';
import 'package:urps_ordein/api/client.dart';
import 'package:urps_ordein/features/user_details/models/info_model.dart';
import 'package:urps_ordein/features/user_details/models/points_line_chart.dart';
import 'package:urps_ordein/features/user_details/models/redemption_model.dart';
import 'package:urps_ordein/features/user_details/models/transaction_model.dart';

class UserServices {
  final Dio _dio = DioClient.instance;
  Future<UserInfo?> getUserDetails(int businessID, String userID) async {
    try {
      final response = await _dio.get(
        '/api/private/v1/businesses/user/details',
        queryParameters: {'business_id': businessID, 'user_id': userID},
      );

      final data = response.data as Map<String, dynamic>;
      return UserInfo.fromJson(data);
    } on DioException catch (e) {
      // Log or handle specific Dio errors
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }

  Future<PointsLineChartResponse?> getPointsLineChart(
    int businessID,
    String userID,
  ) async {
    try {
      final response = await _dio.get(
        '/api/private/v1/businesses/user/timeframes',
        queryParameters: {'business_id': businessID, 'user_id': userID},
      );

      final data = response.data as Map<String, dynamic>;
      return PointsLineChartResponse.fromJson(data);
    } on DioException catch (e) {
      // Handle Dio-specific errors
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }

  Future<TransactionResponse?> getTransactions(int page, int limit) async {
    try {
            final response = await _dio.get(
        '/api/private/v1/transactions',
        queryParameters: {'page': page, 'limit': limit},
      );

      final data = response.data as Map<String, dynamic>;
      return TransactionResponse.fromJson(data);
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }

    Future<RedemptionResponse?> getRedemptions(int page, int limit) async {
    try {
            final response = await _dio.get(
        '/api/private/v1/redemptions',
        queryParameters: {'page': page, 'limit': limit},
      );

      final data = response.data as Map<String, dynamic>;
      return RedemptionResponse.fromJson(data);
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }
}
