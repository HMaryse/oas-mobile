import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'models/facture.dart';

class DetailFactureEcran extends StatelessWidget {
  final Facture facture;

  const DetailFactureEcran({
    super.key,
    required this.facture,
  });

  String libelleStatut(
    String statut,
  ) {
    switch (statut) {
      case "EN_ATTENTE":
        return "En attente";

      case "ACCEPTE":
        return "Acceptée";

      case "REJETE":
        return "Rejetée";

      case "PAYEE":
        return "Payée";

      case "PARTIELLEMENT_PAYEE":
        return "Partiellement payée";

      case "ANNULEE":
        return "Annulée";

      default:
        return statut;
    }
  }

  Color couleurStatut(
    String statut,
  ) {
    switch (statut) {
      case "PAYEE":
        return Colors.green;

      case "PARTIELLEMENT_PAYEE":
        return Colors.orange;

      case "ANNULEE":
      case "REJETE":
        return Colors.red;

      default:
        return CouleursApp.bleuFonce;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor:
            CouleursApp.grisFond,

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Détail Facture",
          style: TextStyle(
            color:
                CouleursApp.bleuFonce,
            fontWeight:
                FontWeight.bold,
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
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Text(
                    facture.numero,

                    style:
                        const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          couleurStatut(
                        facture.statut,
                      ).withOpacity(
                        .15,
                      ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        20,
                      ),
                    ),

                    child: Text(
                      libelleStatut(
                        facture.statut,
                      ),

                      style: TextStyle(
                        color:
                            couleurStatut(
                          facture.statut,
                        ),
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Text(
                    "Créée le ${facture.dateCreation.day}/${facture.dateCreation.month}/${facture.dateCreation.year}",
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Container(
              padding:
                  const EdgeInsets.all(
                16,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: Column(
                children: [
                  _ligneMontant(
                    "Montant HT",
                    facture.montantHT,
                  ),

                  const Divider(),

                  _ligneMontant(
                    "TVA",
                    facture.montantTVA,
                  ),

                  const Divider(),

                  _ligneMontant(
                    "Timbre",
                    facture.montantTimbre,
                  ),

                  const Divider(),

                  _ligneMontant(
                    "Montant TTC",
                    facture.montantTTC,
                  ),

                  const Divider(),

                  _ligneMontant(
                    "Montant total",
                    facture.montantTotal,
                    estTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Container(
              padding:
                  const EdgeInsets.all(
                16,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: Column(
                children: [
                  _ligneMontant(
                    "Montant payé",
                    facture.montantPaye,
                  ),

                  const Divider(),

                  _ligneMontant(
                    "Reste à payer",
                    facture.resteAPayer,
                    estTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(
                16,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  const Text(
                    "Kilométrage",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    "${facture.kilometrage.toStringAsFixed(0)} km",
                  ),
                ],
              ),
            ),

            if (facture.remarque !=
                    null &&
                facture.remarque!
                    .isNotEmpty) ...[
              const SizedBox(
                height: 16,
              ),

              Container(
                width:
                    double.infinity,

                padding:
                    const EdgeInsets
                        .all(16),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius
                          .circular(
                    16,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    const Text(
                      "Remarque",
                      style: TextStyle(
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      facture.remarque!,
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(
              height: 24,
            ),

            if (facture.statut ==
                    "EN_ATTENTE" ||
                facture.statut ==
                    "PARTIELLEMENT_PAYEE")
              Container(
                width:
                    double.infinity,

                padding:
                    const EdgeInsets
                        .all(16),

                decoration:
                    BoxDecoration(
                  color: Colors
                      .orange
                      .shade50,

                  borderRadius:
                      BorderRadius
                          .circular(
                    12,
                  ),
                ),

                child: const Text(
                  "⚠ Cette facture n'est pas encore totalement réglée.",
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _ligneMontant(
    String titre,
    double montant, {
    bool estTotal = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titre,
            style: TextStyle(
              fontWeight: estTotal
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),

        Text(
          "${montant.toStringAsFixed(0)} FCFA",

          style: TextStyle(
            color: estTotal
                ? CouleursApp.orange
                : Colors.black,

            fontWeight: estTotal
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}