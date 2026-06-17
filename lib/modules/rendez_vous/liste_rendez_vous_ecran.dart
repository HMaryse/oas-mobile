import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/carte_rendez_vous.dart';
import 'detail_rendez_vous_ecran.dart';
import 'models/rendez_vous.dart';
import 'repository/rendez_vous_repository.dart';
import 'reservation_rendez_vous_ecran.dart';

class ListeRendezVousEcran extends StatefulWidget {
  const ListeRendezVousEcran({super.key});

  @override
  State<ListeRendezVousEcran> createState() =>
      _ListeRendezVousEcranState();
}

class _ListeRendezVousEcranState
    extends State<ListeRendezVousEcran> {

  final RendezVousRepository repository =
      RendezVousRepository();

  List<RendezVous> rendezVous = [];

  bool chargement = true;

  int filtreSelectionne = 0;

  final List<String> filtres = [
    "Tous",
    "En attente",
    "Confirmés",
    "Refusés",
  ];

  @override
  void initState() {
    super.initState();
    chargerRendezVous();
  }

  Future<void> chargerRendezVous() async {
    try {

      final resultat =
          await repository.getRendezVous();

      setState(() {
        rendezVous = resultat;
        chargement = false;
      });

    } catch (e) {

      setState(() {
        chargement = false;
      });

      debugPrint(
        "Erreur rendez-vous : $e",
      );
    }
  }

  List<RendezVous> get rendezVousFiltres {

    switch (filtreSelectionne) {

      case 1:
        return rendezVous
            .where(
              (e) =>
                  e.statut ==
                  "EN_ATTENTE",
            )
            .toList();

      case 2:
        return rendezVous
            .where(
              (e) =>
                  e.statut ==
                  "CONFIRME",
            )
            .toList();

      case 3:
        return rendezVous
            .where(
              (e) =>
                  e.statut ==
                  "REFUSE",
            )
            .toList();

      default:
        return rendezVous;
    }
  }

  String libelleStatut(
    String statut,
  ) {

    switch (statut) {

      case "EN_ATTENTE":
        return "En attente";

      case "CONFIRME":
        return "Confirmé";

      case "REFUSE":
        return "Refusé";

      default:
        return statut;
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
            color:
                CouleursApp.orange,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: const Text(
          "Mes Rendez-vous",
          style: TextStyle(
            color:
                CouleursApp.bleuFonce,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color:
                  CouleursApp.orange,
            ),
            onPressed: () async {

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ReservationRendezVousEcran(),
                ),
              );

              chargerRendezVous();
            },
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh:
            chargerRendezVous,

        child: ListView(
          padding:
              const EdgeInsets.all(
                  16),

          children: [

            Container(
              padding:
                  const EdgeInsets.all(
                      18),

              decoration:
                  BoxDecoration(
                color:
                    Colors.white,
                borderRadius:
                    BorderRadius.circular(
                        18),
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
                                  0.1),

                      borderRadius:
                          BorderRadius
                              .circular(
                                  12),
                    ),

                    child: const Icon(
                      Icons
                          .calendar_month,
                      color:
                          CouleursApp
                              .orange,
                    ),
                  ),

                  const SizedBox(
                      width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          "${rendezVous.length} rendez-vous",
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
                            height: 4),

                        Text(
                          "${rendezVous.where((e) => e.statut == 'EN_ATTENTE').length} en attente",
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
                height: 20),

            SizedBox(
              height: 42,

              child:
                  ListView.builder(
                scrollDirection:
                    Axis.horizontal,

                itemCount:
                    filtres.length,

                itemBuilder:
                    (context,
                        index) {

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
                        filtres[index],
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
                height: 20),

            if (rendezVousFiltres
                .isEmpty)

              const Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(
                          40),
                  child: Text(
                    "Aucun rendez-vous",
                  ),
                ),
              ),

            ...rendezVousFiltres.map(
              (rdv) {

                final date =
                    rdv.dateRendezVous;

                return CarteRendezVous(
                  date:
                      "${date.day}/${date.month}/${date.year}",

                  heure:
                      "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",

                  vehicule:
                      rdv.vehiculeImmatriculation,

                  motif:
                      rdv.motif,

                  statut:
                      libelleStatut(
                    rdv.statut,
                  ),

                  onDetails:
                      () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DetailRendezVousEcran(
                          rendezVous:
                              rdv,
                        ),
                      ),
                    );
                  },

                  onAnnuler:
                      () {

                    _confirmerAnnulation(
                      context,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            CouleursApp.orange,

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const ReservationRendezVousEcran(),
            ),
          );

          chargerRendezVous();
        },
      ),
    );
  }

  void _confirmerAnnulation(
      BuildContext context) {

    showDialog(
      context: context,

      builder: (_) =>
          AlertDialog(
        title: const Text(
          "Annuler le rendez-vous ?",
        ),

        content: const Text(
          "Cette action ne pourra pas être annulée.",
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(
                  context);
            },
            child:
                const Text("Non"),
          ),

          ElevatedButton(
            style:
                ElevatedButton
                    .styleFrom(
              backgroundColor:
                  Colors.red,
            ),

            onPressed: () {

              Navigator.pop(
                  context);

              ScaffoldMessenger.of(
                      context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    "Fonction d'annulation à connecter",
                  ),
                ),
              );
            },

            child:
                const Text("Oui"),
          ),
        ],
      ),
    );
  }
}