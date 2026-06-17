import 'dart:convert';

import '../../../core/services/api_service.dart';
import '../models/vehicule_model.dart';

class VehiculeRepository {
  final ApiService _apiService =
      ApiService();

  Future<List<VehiculeModel>>
      getVehicules() async {

    final response =
        await _apiService.get(
      '/client/vehicules',
    );

    if (response.statusCode == 200) {

      final List data =
          jsonDecode(response.body);

      return data
          .map(
            (e) => VehiculeModel.fromJson(e),
          )
          .toList();
    }

    throw Exception(
      'Erreur chargement véhicules',
    );
  }
  Future<void> ajouterVehicule({
    required String immatriculation,
    required int annee,
    required String modele,
    required String marque,
    required double kilometrage,
    required String numeroChassis,
  }) async {

    final response = await _apiService.post(
      '/client/vehicules',
      {
        "immatriculation": immatriculation,
        "annee": annee,
        "modele": modele,
        "marque": marque,
        "kilometrage": kilometrage,
        "numeroChassis": numeroChassis,
      },
    );

    if (response.statusCode != 200 &&
    response.statusCode != 201) {

  print("STATUS = ${response.statusCode}");
  print("BODY = ${response.body}");

  throw Exception(
    "Status: ${response.statusCode} - ${response.body}",
  );
}
  }
}