import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import 'storage_service.dart';

class ApiService {
  Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {

    final token =
        await StorageService.getToken();

    return await http.post(
      Uri.parse(
        '${ApiConfig.baseUrl}$endpoint',
      ),

      headers: {
        'Authorization':
            'Bearer $token',

        'Content-Type':
            'application/json',
      },

      body: jsonEncode(data),
    );
}
  Future<http.Response> get(
    String endpoint,
  ) async {
    final token =
        await StorageService.getToken();

    return await http.get(
      Uri.parse(
        '${ApiConfig.baseUrl}$endpoint',
      ),
      headers: {
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }
}