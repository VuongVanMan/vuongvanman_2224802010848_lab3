import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final Dio dio = Dio();

  final String baseUrl = "https://69dde357410caa3d47ba2203.mockapi.io/";

  Future<void> send(String endpoint, Map<String, dynamic> data) async {
    try {
      debugPrint("=== REQUEST INFO ===");
      debugPrint("URL: $baseUrl$endpoint");
      debugPrint("Method: POST");
      debugPrint("Data: $data");

      final Response response = await dio.post("$baseUrl$endpoint", data: data);

      debugPrint("=== RESPONSE INFO ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Data: ${response.data}");
      debugPrint("Headers: ${response.headers}");
    } catch (e) {
      debugPrint("=== ERROR ===");
      debugPrint("Dio error: $e");
    }
  }
}
