import 'package:dio/dio.dart';
import 'package:urps_ordein/api/client.dart';

class APIService<T> {
  final Dio _dio = DioClient.instance;
  final String endpoint;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  APIService({
    required this.endpoint,
    required this.fromJson,
    required this.toJson,
  });

  Future<List<T>> getAll(int page, limit) async {
    final response = await _dio.get('$endpoint?page=$page&limit=$limit');

    // Ensure the response is a Map and contains a List under 'data'
    if (response.data is Map<String, dynamic> && response.data['data'] is List) {
      final List<dynamic> data = response.data['data'];
      return data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Unexpected API format: ${response.data}');
    }
  }

  Future<List<T>> getListAll(int page, int limit) async {
  final response = await _dio.get('$endpoint?page=$page&limit=$limit');
  final data = response.data;

  if (data is Map<String, dynamic> && data['data'] is List) {
    return (data['data'] as List)
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  } else if (data is List) {
    return data
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Unexpected API format: $data');
  }
}

Future<T> get() async {
  final response = await _dio.get(endpoint);
  final data = response.data;

  if (data is Map<String, dynamic>) {
    return fromJson(data);
  } else {
    throw Exception('Unexpected API format');
  }
}



  Future<Map<String, dynamic>> getPaginatedRaw(int page, int limit) async {
  final response = await _dio.get('$endpoint?page=$page&limit=$limit');

  if (response.data is Map<String, dynamic> && response.data['data'] is List) {
    return {
      'data': response.data['data'],
      'total': response.data['total'] ?? 0,
      'page': response.data['page'] ?? page,
      'limit': response.data['limit'] ?? limit,
    };
  } else {
    throw Exception('Unexpected API format: ${response.data}');
  }
}


  Future<T> getById(int id) async {
    final response = await _dio.get('$endpoint/$id');

    // If the item is also wrapped in a "data" key, update this accordingly
    if (response.data is Map<String, dynamic>) {
      final data = response.data['data'] ?? response.data;
      return fromJson(data as Map<String, dynamic>);
    } else {
      throw Exception('Unexpected API format: ${response.data}');
    }
  }

  Future<T> create(T item) async {
    final response = await _dio.post(endpoint, data: toJson(item));
    final data = response.data['data'] ?? response.data;
    return fromJson(data as Map<String, dynamic>);
  }

  Future<T> update(int id, T item) async {
    final response = await _dio.put('$endpoint/$id', data: toJson(item));
    final data = response.data['data'] ?? response.data;
    return fromJson(data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete('$endpoint/$id');
  }
}
