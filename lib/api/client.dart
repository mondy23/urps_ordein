import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:15001',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZXhwIjoxNzUzNTg0OTI5LCJ1c2VybmFtZSI6ImFkbWluMDAxMSJ9.aAvypT3DHItjHJ7yosghG9-UHa46ZjDcxWPH-v4sqEM',
      },
    ),
  );

  static Dio get instance => _dio;
}
