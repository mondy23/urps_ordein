import 'package:dio/dio.dart';
import 'package:urps_ordein/features/user_details/models/response_model.dart';

class UserServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:15001',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZXhwIjoxNzUzMzQzNzMzLCJ1c2VybmFtZSI6ImFkbWluMDAxMSJ9.egxCBg-sIVDAhVccILoDnK59FlPFhica4_ZDGV4MtAo',
      },
    ),
  );

  Future<UserDetailsResponseModel?> getUserDetails(
    int businessID,
    String userID,
    int limit,
    int offset
  ) async {
    try {
      final response = await _dio.get(
        '/api/private/v1/businesses/user/details',
        queryParameters: {
          'business_id': businessID,
          'user_id': userID,
          'limit': limit,
          'offset': offset,
        },
      );

      final data = response.data as Map<String, dynamic>;
      return UserDetailsResponseModel.fromJson(data);
    } on DioException catch (e) {
      // Log or handle specific Dio errors
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }
}
