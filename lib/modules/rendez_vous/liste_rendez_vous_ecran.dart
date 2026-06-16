import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/carte_rendez_vous.dart';
import 'detail_rendez_vous_ecran.dart';
import 'reservation_rendez_vous_ecran.dart';

class ListeRendezVousEcran extends StatefulWidget {
  const ListeRendezVousEcran({super.key});

  @override
  State<ListeRendezVousEcran> createState() =>
      _ListeRendezVousEcranState();
}

class _ListeRendezVousEcranState
    extends State<ListeRendezVousEcran> {
  int filtreSelectionne = 0;

  final List<String> filtres = [
    "Tous",
    "En attente",
    "Confirmés",
    "Refusés",
  ];

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
          "Mes Rendez-vous",
          style: TextStyle(
            color: CouleursApp.bleuFonce,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: CouleursApp.orange,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ReservationRendezVousEcran(),
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),

              children: [
                Container(
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(18),
                  ),

                  child: Row(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: CouleursApp.orange
                              .withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(
                                  12),
                        ),

                        child: const Icon(
                          Icons.calendar_month,
                          color:
                              CouleursApp.orange,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            Text(
                              "3 rendez-vous",
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "1 confirmé • 1 en attente • 1 refusé",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 42,

                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal,

                    itemCount: filtres.length,

                    itemBuilder:
                        (context, index) {
                      final actif =
                          filtreSelectionne ==
                              index;

                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          right: 8,
                        ),

                        child: ChoiceChip(
                          label:
                              Text(filtres[index]),

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

                const SizedBox(height: 20),

                CarteRendezVous(
                  date: "15 Juin 2026",
                  heure: "09:30",
                  vehicule:
                      "Toyota Hilux - DK-8849-B",
                  motif:
                      "Changement plaquettes de frein",
                  statut: "Confirmé",

                  onDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const DetailRendezVousEcran(),
                      ),
                    );
                  },

                  onAnnuler: () {
                    _confirmerAnnulation(
                        context);
                  },
                ),

                CarteRendezVous(
                  date: "22 Juin 2026",
                  heure: "14:00",
                  vehicule:
                      "Renault Clio IV - DK-2208-CD",
                  motif:
                      "Diagnostic bruit moteur",
                  statut: "En attente",

                  onDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const DetailRendezVousEcran(),
                      ),
                    );
                  },

                  onAnnuler: () {
                    _confirmerAnnulation(
                        context);
                  },
                ),

                CarteRendezVous(
                  date: "04 Juillet 2026",
                  heure: "11:00",
                  vehicule:
                      "Toyota Hilux - DK-8849-B",
                  motif:
                      "Révision complète",
                  statut: "Refusé",

                  onDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const DetailRendezVousEcran(),
                      ),
                    );
                  },

                  onAnnuler: () {
                    _confirmerAnnulation(
                        context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            CouleursApp.orange,

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const ReservationRendezVousEcran(),
            ),
          );
        },
      ),
    );
  }

  void _confirmerAnnulation(
      BuildContext context) {
    showDialog(
      context: context,

      builder: (_) => AlertDialog(
        title: const Text(
          "Annuler le rendez-vous ?",
        ),

        content: const Text(
          "Cette action ne pourra pas être annulée.",
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Non"),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),

            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    "Rendez-vous annulé",
                  ),
                ),
              );
            },

            child: const Text("Oui"),
          ),
        ],
      ),
    );
  }
}