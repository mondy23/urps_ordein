import 'package:dio/dio.dart';

final String token =
    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZXhwIjoxNzU0MjY3MzQxLCJ1c2VybmFtZSI6ImFkbWluMDAxMSJ9.N1anH_QM8KTz9Bz7zt4p02uk3pkCIJeVCChL5Dyv6g4';
final baseUrl =  'http://127.0.0.1:15001';
class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: 'https://bakawan-reward-system.fortress-asya.com',
      baseUrl: baseUrl,
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
