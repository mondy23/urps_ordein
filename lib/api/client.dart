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
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MiwiZXhwIjoxNzUzMzI0NTE0LCJ1c2VybmFtZSI6ImFkbWluMDAxMSJ9.03UacMlBZQzw1DwIAUgZA69sH_lgTgGmqMvgI1HU06M',
      },
    ),
  );

  static Dio get instance => _dio;
}
