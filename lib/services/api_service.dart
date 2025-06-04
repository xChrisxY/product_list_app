import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'http://192.168.1.93:8000/api/v1/';

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(baseUrl + endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
