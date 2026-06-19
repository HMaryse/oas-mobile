import 'dart:convert';

import '../../../core/services/api_service.dart';
import '../models/facture.dart';

class FactureRepository {
  final ApiService _apiService =
      ApiService();

  Future<List<Facture>>
      getFactures() async {
    final response =
        await _apiService.get(
      '/client/factures',
    );

    if (response.statusCode == 200) {
      final List data =
          jsonDecode(response.body);

      return data
          .map(
            (e) =>
                Facture.fromJson(e),
          )
          .toList();
    }

    throw Exception(
      'Erreur chargement factures',
    );
  }

  Future<Facture> getFacture(
    int id,
  ) async {
    final response =
        await _apiService.get(
      '/client/factures/$id',
    );

    if (response.statusCode == 200) {
      return Facture.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception(
      'Erreur détail facture',
    );
  }
}