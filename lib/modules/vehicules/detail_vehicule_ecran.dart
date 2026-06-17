import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'models/vehicule_model.dart';

class DetailVehiculeEcran extends StatelessWidget {
  final VehiculeModel vehicule;

  const DetailVehiculeEcran({
    super.key,
    required this.vehicule,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CouleursApp.orange,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: const Text(
          "Détails Véhicule",
          style: TextStyle(
            color: CouleursApp.bleuFonce,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [

                  Container(
                    width: 70,
                    height: 70,

                    decoration: BoxDecoration(
                      color: CouleursApp.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: const Icon(
                      Icons.directions_car,
                      color: CouleursApp.orange,
                      size: 35,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          "${vehicule.marque} ${vehicule.modele}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CouleursApp.bleuFonce,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          vehicule.immatriculation,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Row(
                          children: [

                            Icon(
                              Icons.verified,
                              color: Colors.green,
                              size: 18,
                            ),

                            SizedBox(width: 5),

                            Text(
                              "Véhicule enregistré",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _carteInfo(
              Icons.calendar_month,
              "Année",
              vehicule.annee.toString(),
            ),

            _carteInfo(
              Icons.speed,
              "Kilométrage",
              "${vehicule.kilometrage.toInt()} km",
            ),

            _carteInfo(
              Icons.qr_code,
              "Numéro de châssis",
              vehicule.numeroChassis,
            ),

            const SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Informations véhicule",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Text(
                "Les informations affichées proviennent directement de votre compte client.",
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.arrow_back,
                ),

                label: const Text(
                  "Retour",
                ),

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      CouleursApp.orange,
                  foregroundColor:
                      Colors.white,
                ),

                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _carteInfo(
    IconData icone,
    String label,
    String valeur,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [

          Icon(
            icone,
            color: CouleursApp.orange,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  valeur,
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}