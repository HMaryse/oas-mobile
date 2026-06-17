import 'dart:convert';

import '../../../core/services/api_service.dart';
import '../models/rendez_vous.dart';

class RendezVousRepository {

  final ApiService _apiService =
      ApiService();

  Future<List<RendezVous>>
      getRendezVous() async {

    final response =
        await _apiService.get(
      '/client/rendezvous',
    );

    if (response.statusCode == 200) {

      final List data =
          jsonDecode(response.body);

      return data
          .map(
            (e) => RendezVous.fromJson(e),
          )
          .toList();
    }

    throw Exception(
      'Erreur chargement rendez-vous',
    );
  }

  Future<void> creerRendezVous({
    required DateTime dateRendezVous,
    required String motif,
    required int vehiculeId,
  }) async {

    final response =
        await _apiService.post(
      '/client/rendezvous',
      {
        "dateRendezVous":
            dateRendezVous.toIso8601String(),
        "motif": motif,
        "vehiculeId": vehiculeId,
      },
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {

      throw Exception(
        "Erreur création rendez-vous",
      );
    }
  }
}