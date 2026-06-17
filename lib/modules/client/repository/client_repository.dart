import 'dart:convert';

import '../../../core/services/api_service.dart';
import '../models/client_model.dart';

class ClientRepository {
  final ApiService _apiService =
      ApiService();

  Future<ClientModel> getProfil() async {
    final response =
        await _apiService.get(
      '/client/me',
    );

    if (response.statusCode == 200) {
      return ClientModel.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception(
      'Impossible de charger le profil',
    );
  }
}