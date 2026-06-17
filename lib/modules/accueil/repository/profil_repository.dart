import 'dart:convert';

import '../../../core/services/api_service.dart';
import '../models/profil_model.dart';

class ProfilRepository {

  final ApiService _apiService =
      ApiService();

  Future<ProfilModel> getProfil() async {

    final response =
        await _apiService.get(
      '/client/me',
    );

    if (response.statusCode == 200) {

      return ProfilModel.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception(
      'Erreur chargement profil',
    );
  }
}