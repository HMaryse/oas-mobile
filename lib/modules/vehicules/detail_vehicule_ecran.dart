import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'modifier_vehicule_ecran.dart';

class DetailVehiculeEcran extends StatelessWidget {
  const DetailVehiculeEcran({super.key});

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

        actions: const []
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
                      color: CouleursApp.orange
                          .withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    child: const Icon(
                      Icons.directions_car,
                      color: CouleursApp.orange,
                      size: 35,
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Toyota Hilux",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                CouleursApp.bleuFonce,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "DK-8849-B",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(height: 8),

                        Row(
                          children: [

                            Icon(
                              Icons.verified,
                              color: Colors.green,
                              size: 18,
                            ),

                            SizedBox(width: 5),

                            Text(
                              "Véhicule actif",
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
              "2022",
            ),

            _carteInfo(
              Icons.speed,
              "Kilométrage",
              "34 000 km",
            ),

            _carteInfo(
              Icons.qr_code,
              "Numéro de châssis",
              "AHR1239840294820",
            ),

            const SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Historique des réparations",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(height: 12),

            _historique(
              "Changement plaquettes",
              "En cours",
              Colors.orange,
            ),

            _historique(
              "Révision 30 000 km",
              "Terminé",
              Colors.green,
            ),

            _historique(
              "Vidange + filtres",
              "Terminé",
              Colors.green,
            ),

            const SizedBox(height: 30),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.edit_outlined,
                    ),

                    label: const Text(
                      "Information",
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          CouleursApp.orange,
                      foregroundColor:
                          Colors.white,
                    ),

                    onPressed: () {
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),

                    label: const Text(
                      "Supprimer",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),

                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _carteInfo(
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

  Widget _historique(
    String titre,
    String statut,
    Color couleur,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [

          Icon(
            Icons.build_circle_outlined,
            color: couleur,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(titre),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),

            decoration: BoxDecoration(
              color:
                  couleur.withOpacity(0.15),
              borderRadius:
                  BorderRadius.circular(
                      20),
            ),

            child: Text(
              statut,
              style: TextStyle(
                color: couleur,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}