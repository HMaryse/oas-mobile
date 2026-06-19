import 'dart:convert';

import '../../../core/services/api_service.dart';
import '../models/reparation.dart';

class ReparationRepository {
  final ApiService _apiService =
      ApiService();

  Future<List<Reparation>>
      getReparations() async {
    final response =
        await _apiService.get(
      '/client/interventions',
    );

    if (response.statusCode == 200) {
      final List data =
          jsonDecode(response.body);

      return data
          .map(
            (e) => Reparation.fromJson(e),
          )
          .toList();
    }

    throw Exception(
      'Erreur chargement réparations',
    );
  }

  Future<Reparation>
      getDetailReparation(
    int id,
  ) async {
    final response =
        await _apiService.get(
      '/client/interventions/$id',
    );

    if (response.statusCode == 200) {
      return Reparation.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception(
      'Erreur détail réparation',
    );
  }
}