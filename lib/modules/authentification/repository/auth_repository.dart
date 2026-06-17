import 'dart:convert';

import '../../../core/services/api_service.dart';
import '../../../core/services/storage_service.dart';
import '../models/auth_response_model.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<AuthResponseModel> login({
    required String username,
    required String password,
  }) async {
    final response = await _apiService.post(
      '/auth/signin',
      {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final authResponse =
          AuthResponseModel.fromJson(data);

      await StorageService.saveToken(
        authResponse.token,
      );

      await StorageService.saveUsername(
        authResponse.username,
      );

      return authResponse;
    }

    throw Exception(
      'Identifiants incorrects',
    );
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String username,
    required String password,
  }) async {
    final response = await _apiService.post(
      '/auth/signup',
      {
        "matricule": null,
        "phone": phone,
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "type": "CLIENT",
        "role": null,
      },
    );

    if (response.statusCode != 201 &&
        response.statusCode != 200) {
      throw Exception(
        'Erreur lors de l\'inscription',
      );
    }
  }

  Future<void> logout() async {
    await StorageService.clear();
  }
}