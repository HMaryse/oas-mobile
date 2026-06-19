import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'models/reparation.dart';

class DetailReparationEcran extends StatelessWidget {
  final Reparation reparation;

  const DetailReparationEcran({
    super.key,
    required this.reparation,
  });

  List<String> get etapes => [
        "A_FAIRE",
        "EN_DIAGNOSTIC",
        "EN_ATTENTE_PROFORMA",
        "EN_ATTENTE_COMMANDE",
        "EN_COURS",
        "TERMINE",
        "LIVRE",
      ];

  String libelleEtape(String etape) {
    switch (etape) {
      case "A_FAIRE":
        return "Réception du véhicule";

      case "EN_DIAGNOSTIC":
        return "Diagnostic";

      case "EN_ATTENTE_PROFORMA":
        return "Attente validation devis";

      case "EN_ATTENTE_COMMANDE":
        return "Commande des pièces";

      case "EN_COURS":
        return "Réparation en cours";

      case "TERMINE":
        return "Réparation terminée";

      case "LIVRE":
        return "Véhicule livré";

      default:
        return etape;
    }
  }

  String libelleStatut(String statut) {
    switch (statut) {
      case "A_FAIRE":
        return "À faire";

      case "EN_DIAGNOSTIC":
        return "Diagnostic";

      case "EN_ATTENTE_PROFORMA":
        return "Attente devis";

      case "EN_ATTENTE_COMMANDE":
        return "Attente pièces";

      case "EN_COURS":
        return "En cours";

      case "TERMINE":
        return "Terminée";

      case "LIVRE":
        return "Livrée";

      default:
        return statut;
    }
  }

  Color couleurStatut(String statut) {
    switch (statut) {
      case "TERMINE":
        return Colors.green;

      case "LIVRE":
        return Colors.blue;

      case "EN_COURS":
        return Colors.orange;

      default:
        return CouleursApp.bleuFonce;
    }
  }

  @override
  Widget build(BuildContext context) {
    final indexActuel =
        etapes.indexOf(reparation.statut);

    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "Suivi Réparation",
          style: TextStyle(
            color: CouleursApp.bleuFonce,
            fontWeight: FontWeight.bold,
          ),
        ),

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CouleursApp.orange,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    reparation.numero,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: couleurStatut(
                        reparation.statut,
                      ).withOpacity(0.15),

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Text(
                      libelleStatut(
                        reparation.statut,
                      ),
                      style: TextStyle(
                        color: couleurStatut(
                          reparation.statut,
                        ),
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Description des travaux",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    reparation
                            .descriptionTravaux
                            .isEmpty
                        ? "Aucune description"
                        : reparation
                            .descriptionTravaux,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            if (reparation.listeReception !=
                    null &&
                reparation
                    .listeReception!
                    .isNotEmpty)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Liste de réception",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      reparation
                          .listeReception!,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            if (reparation.listeDefauts !=
                    null &&
                reparation
                    .listeDefauts!
                    .isNotEmpty)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Défauts constatés",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      reparation
                          .listeDefauts!,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Progression",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ...List.generate(
                    etapes.length,
                    (index) {
                      final termine =
                          index <= indexActuel;

                      return Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Icon(
                            termine
                                ? Icons
                                    .check_circle
                                : Icons
                                    .radio_button_unchecked,
                            color: termine
                                ? Colors.green
                                : Colors.grey,
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets
                                      .only(
                                bottom: 18,
                              ),
                              child: Text(
                                libelleEtape(
                                  etapes[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            if (reparation.statut ==
                "EN_ATTENTE_PROFORMA") ...[
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color:
                      Colors.orange.shade50,
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),

                child: const Text(
                  "Votre véhicule est en attente de validation du devis. Consultez vos proformas pour poursuivre la réparation.",
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}