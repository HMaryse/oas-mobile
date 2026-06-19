import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'detail_facture_ecran.dart';
import 'models/facture.dart';
import 'repository/facture_repository.dart';

class FacturesEcran extends StatefulWidget {
  const FacturesEcran({super.key});

  @override
  State<FacturesEcran> createState() =>
      _FacturesEcranState();
}

class _FacturesEcranState
    extends State<FacturesEcran> {
  final FactureRepository repository =
      FactureRepository();

  List<Facture> factures = [];

  bool chargement = true;

  int filtreSelectionne = 0;

  final List<String> filtres = [
    "Toutes",
    "En attente",
    "Partiellement payées",
    "Payées",
  ];

  @override
  void initState() {
    super.initState();
    chargerFactures();
  }

  Future<void> chargerFactures() async {
    try {
      final resultat =
          await repository.getFactures();

      setState(() {
        factures = resultat;
        chargement = false;
      });
    } catch (e) {
      setState(() {
        chargement = false;
      });

      debugPrint(
        "Erreur factures : $e",
      );
    }
  }

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

      case "REJETE":
      case "ANNULEE":
        return Colors.red;

      default:
        return CouleursApp.bleuFonce;
    }
  }

  List<Facture> get facturesFiltrees {
    switch (filtreSelectionne) {
      case 1:
        return factures.where((f) {
          return f.statut ==
                  "EN_ATTENTE" ||
              f.statut ==
                  "ACCEPTE";
        }).toList();

      case 2:
        return factures.where((f) {
          return f.statut ==
              "PARTIELLEMENT_PAYEE";
        }).toList();

      case 3:
        return factures.where((f) {
          return f.statut ==
              "PAYEE";
        }).toList();

      default:
        return factures;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chargement) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    final totalFactures =
        factures.length;

    final totalPayees =
        factures
            .where(
              (f) =>
                  f.statut ==
                  "PAYEE",
            )
            .length;

    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor:
            CouleursApp.grisFond,
        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Mes Factures",
          style: TextStyle(
            color:
                CouleursApp.bleuFonce,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh:
            chargerFactures,

        child: ListView(
          padding:
              const EdgeInsets.all(
            16,
          ),

          children: [
            Container(
              padding:
                  const EdgeInsets.all(
                18,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius
                        .circular(
                  16,
                ),
              ),

              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets
                            .all(12),

                    decoration:
                        BoxDecoration(
                      color:
                          CouleursApp
                              .orange
                              .withOpacity(
                        .1,
                      ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),
                    ),

                    child: const Icon(
                      Icons.receipt_long,
                      color:
                          CouleursApp
                              .orange,
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                        Text(
                          "$totalFactures factures",

                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,

                            fontSize:
                                18,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          "$totalPayees payées",

                          style:
                              const TextStyle(
                            color:
                                Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            SizedBox(
              height: 42,

              child:
                  ListView.builder(
                scrollDirection:
                    Axis.horizontal,

                itemCount:
                    filtres.length,

                itemBuilder:
                    (
                  context,
                  index,
                ) {
                  final actif =
                      filtreSelectionne ==
                          index;

                  return Padding(
                    padding:
                        const EdgeInsets
                            .only(
                      right: 8,
                    ),

                    child:
                        ChoiceChip(
                      label: Text(
                        filtres[
                            index],
                      ),

                      selected:
                          actif,

                      selectedColor:
                          CouleursApp
                              .bleuFonce,

                      labelStyle:
                          TextStyle(
                        color: actif
                            ? Colors
                                .white
                            : Colors
                                .black,
                      ),

                      onSelected:
                          (_) {
                        setState(
                          () {
                            filtreSelectionne =
                                index;
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            if (facturesFiltrees
                .isEmpty)
              const Padding(
                padding:
                    EdgeInsets.all(
                  40,
                ),

                child: Center(
                  child: Text(
                    "Aucune facture disponible",
                  ),
                ),
              ),

            ...facturesFiltrees
                .map(
              (facture) =>
                  Container(
                margin:
                    const EdgeInsets
                        .only(
                  bottom: 16,
                ),

                padding:
                    const EdgeInsets
                        .all(
                  16,
                ),

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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            facture
                                .numero,

                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,

                              fontSize:
                                  16,
                            ),
                          ),
                        ),

                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal:
                                12,

                            vertical:
                                6,
                          ),

                          decoration:
                              BoxDecoration(
                            color:
                                couleurStatut(
                              facture
                                  .statut,
                            ).withOpacity(
                                    .15),

                            borderRadius:
                                BorderRadius.circular(
                                    20),
                          ),

                          child: Text(
                            libelleStatut(
                              facture
                                  .statut,
                            ),

                            style:
                                TextStyle(
                              color:
                                  couleurStatut(
                                facture
                                    .statut,
                              ),

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Text(
                      "Montant total : ${facture.montantTotal.toStringAsFixed(0)} FCFA",
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(
                      "Montant payé : ${facture.montantPaye.toStringAsFixed(0)} FCFA",
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(
                      "Reste : ${facture.resteAPayer.toStringAsFixed(0)} FCFA",
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    SizedBox(
                      width:
                          double.infinity,

                      child:
                          ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              CouleursApp
                                  .orange,

                          foregroundColor:
                              Colors.white,
                        ),

                        onPressed:
                            () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      DetailFactureEcran(
                                facture:
                                    facture,
                              ),
                            ),
                          );
                        },

                        child:
                            const Text(
                          "Voir détails",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}