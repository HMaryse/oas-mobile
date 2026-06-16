import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/carte_rendez_vous.dart';

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
    "Refusés"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,

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
            onPressed: () {},

            icon: const Icon(
              Icons.add,
              color: CouleursApp.orange,
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            SizedBox(
              height: 40,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: filtres.length,

                itemBuilder: (context, index) {

                  final selectionne =
                      filtreSelectionne == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        filtreSelectionne = index;
                      });
                    },

                    child: Container(
                      margin:
                          const EdgeInsets.only(right: 10),

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        color: selectionne
                            ? CouleursApp.bleuFonce
                            : Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),
                      ),

                      child: Text(
                        filtres[index],

                        style: TextStyle(
                          color: selectionne
                              ? Colors.white
                              : Colors.black,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [

                  CarteRendezVous(
                    date: "15\nJuin",
                    heure: "09:30",
                    vehicule:
                        "Toyota Hilux - DK-8849-B",
                    motif:
                        "Changement plaquettes de frein",
                    statut: "Confirmé",
                  ),

                  CarteRendezVous(
                    date: "22\nJuin",
                    heure: "14:00",
                    vehicule:
                        "Renault Clio - DK-2208-CD",
                    motif:
                        "Diagnostic bruit moteur",
                    statut: "En attente",
                  ),

                  CarteRendezVous(
                    date: "04\nJuil",
                    heure: "11:00",
                    vehicule:
                        "Toyota Hilux - DK-8849-B",
                    motif:
                        "Révision complète",
                    statut: "Refusé",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}