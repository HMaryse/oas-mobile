import 'dart:convert';

import '../../../core/services/api_service.dart';

class ParametresRepository {

  final ApiService _apiService =
      ApiService();

  Future<Map<String, dynamic>>
      recupererProfil() async {

    final response =
        await _apiService.get(
      '/client/me',
    );

    if (response.statusCode == 200) {
      return jsonDecode(
        response.body,
      );
    }

    throw Exception(
      'Erreur chargement profil',
    );
  }

  Future<List<dynamic>>
      recupererNotifications() async {

    final response =
        await _apiService.get(
      '/client/notifications',
    );

    if (response.statusCode == 200) {
      return jsonDecode(
        response.body,
      );
    }

    throw Exception(
      'Erreur chargement notifications',
    );
  }

  Future<void> changerMotDePasse({
    required String username,
    required String ancienMotDePasse,
    required String nouveauMotDePasse,
  }) async {

    final response =
        await _apiService.post(
      '/auth/change-password',
      {
        'username': username,
        'oldPassword':
            ancienMotDePasse,
        'newPassword':
            nouveauMotDePasse,
      },
    );

    if (response.statusCode != 200) {

      throw Exception(
      response.body,
    );
    }
  }
}