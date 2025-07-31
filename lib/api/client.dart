import 'package:dio/dio.dart';

final String token =
    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZXhwIjoxNzU0MDA3MDAxLCJ1c2VybmFtZSI6ImFkbWluMDAxMSJ9.s8qLb3xqU1AVyswAFFb8KTqQiN4lVdiKpiGHAvRwMhg';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:15001',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      },
    ),
  );

  static Dio get instance => _dio;
}
