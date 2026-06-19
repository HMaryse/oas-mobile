import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'detail_reparation_ecran.dart';
import 'models/reparation.dart';
import 'repository/reparation_repository.dart';

class ReparationsEcran extends StatefulWidget {
  const ReparationsEcran({super.key});

  @override
  State<ReparationsEcran> createState() =>
      _ReparationsEcranState();
}

class _ReparationsEcranState
    extends State<ReparationsEcran> {
  final ReparationRepository repository =
      ReparationRepository();

  List<Reparation> reparations = [];

  bool chargement = true;

  int filtreSelectionne = 0;

  final List<String> filtres = [
    "Toutes",
    "En cours",
    "Terminées",
    "Livrées",
  ];

  @override
  void initState() {
    super.initState();
    chargerReparations();
  }

  Future<void> chargerReparations() async {
    try {
      final resultat =
          await repository.getReparations();

      setState(() {
        reparations = resultat;
        chargement = false;
      });
    } catch (e) {
      setState(() {
        chargement = false;
      });

      debugPrint(
        'Erreur réparations : $e',
      );
    }
  }

  String libelleStatut(
    String statut,
  ) {
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

  Color couleurStatut(
    String statut,
  ) {
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

  List<Reparation> get reparationsFiltrees {
    switch (filtreSelectionne) {
      case 1:
        return reparations.where((r) {
          return r.statut != "TERMINE" &&
              r.statut != "LIVRE";
        }).toList();

      case 2:
        return reparations.where((r) {
          return r.statut == "TERMINE";
        }).toList();

      case 3:
        return reparations.where((r) {
          return r.statut == "LIVRE";
        }).toList();

      default:
        return reparations;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chargement) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final nbEnCours =
        reparations.where((r) {
      return r.statut != "TERMINE" &&
          r.statut != "LIVRE";
    }).length;

    final nbTerminees =
        reparations.where((r) {
      return r.statut == "TERMINE";
    }).length;

    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor:
            CouleursApp.grisFond,
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
          "Mes Réparations",
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
            chargerReparations,

        child: ListView(
          padding:
              const EdgeInsets.all(16),

          children: [
            Container(
              padding:
                  const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
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
                        0.1,
                      ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),
                    ),

                    child: const Icon(
                      Icons.build,
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
                          "${reparations.length} réparations",
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          "$nbEnCours en cours • $nbTerminees terminées",
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

              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal,

                itemCount:
                    filtres.length,

                itemBuilder:
                    (context, index) {
                  final actif =
                      filtreSelectionne ==
                          index;

                  return Padding(
                    padding:
                        const EdgeInsets
                            .only(
                      right: 8,
                    ),

                    child: ChoiceChip(
                      label: Text(
                        filtres[index],
                      ),

                      selected: actif,

                      selectedColor:
                          CouleursApp
                              .bleuFonce,

                      labelStyle:
                          TextStyle(
                        color: actif
                            ? Colors.white
                            : Colors.black,
                      ),

                      onSelected: (_) {
                        setState(() {
                          filtreSelectionne =
                              index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            if (reparationsFiltrees
                .isEmpty)
              const Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(40),
                  child: Text(
                    "Aucune réparation trouvée",
                  ),
                ),
              ),

            ...reparationsFiltrees
                .map(
              (reparation) =>
                  Container(
                margin:
                    const EdgeInsets.only(
                  bottom: 16,
                ),

                padding:
                    const EdgeInsets.all(
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
                            reparation
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
                              reparation
                                  .statut,
                            ).withOpacity(
                                    .15),

                            borderRadius:
                                BorderRadius.circular(
                                    20),
                          ),

                          child: Text(
                            libelleStatut(
                              reparation
                                  .statut,
                            ),

                            style:
                                TextStyle(
                              color:
                                  couleurStatut(
                                reparation
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
                      reparation
                          .descriptionTravaux,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      "Créée le ${reparation.dateCreation.day}/${reparation.dateCreation.month}/${reparation.dateCreation.year}",

                      style:
                          const TextStyle(
                        color:
                            Colors.grey,
                      ),
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
                                      DetailReparationEcran(
                                reparation:
                                    reparation,
                              ),
                            ),
                          );
                        },

                        child:
                            const Text(
                          "Voir le suivi",
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