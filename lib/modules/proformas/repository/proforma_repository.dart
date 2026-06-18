import 'dart:convert';

import '../../../core/services/api_service.dart';
import '../models/proforma.dart';

class ProformaRepository {
  final ApiService _apiService =
      ApiService();

  Future<List<Proforma>>
      getProformas() async {

    final response =
        await _apiService.get(
      '/client/proformas',
    );

    if (response.statusCode == 200) {

      final List data =
          jsonDecode(response.body);

      return data
          .map(
            (e) =>
                Proforma.fromJson(e),
          )
          .toList();
    }

    throw Exception(
      'Erreur chargement proformas',
    );
  }

  Future<void> validerProforma(
    int proformaId,
  ) async {

    final response =
        await _apiService.put(
      '/client/proformas/$proformaId/valider',
    );

    if (response.statusCode != 200) {

      throw Exception(
        'Erreur validation proforma',
      );
    }
  }

  Future<void> refuserProforma(
    int proformaId,
  ) async {

    final response =
        await _apiService.put(
      '/client/proformas/$proformaId/refuser',
    );

    if (response.statusCode != 200) {

      throw Exception(
        'Erreur refus proforma',
      );
    }
  }
}