import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'modifier_rendez_vous_ecran.dart';

class DetailRendezVousEcran extends StatelessWidget {
  const DetailRendezVousEcran({super.key});

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
          "Détails Rendez-vous",
          style: TextStyle(
            color: CouleursApp.bleuFonce,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: CouleursApp.orange,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ModifierRendezVousEcran(),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: CouleursApp.bleuFonce,
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 40,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "15 Juin 2026",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "09:30",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.green
                          .withOpacity(0.2),

                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),

                    child: const Text(
                      "Confirmé",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _blocInfo(
              icon: Icons.build_circle_outlined,
              titre: "Motif",
              contenu:
                  "Changement plaquettes de frein",
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: const Row(
                children: [

                  CircleAvatar(
                    backgroundColor:
                        CouleursApp.orange,

                    child: Icon(
                      Icons.directions_car,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Toyota Hilux",
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "DK-8849-B",
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

            const SizedBox(height: 12),

            _blocInfo(
              icon: Icons.info_outline,
              titre:
                  "Commentaire de l'atelier",
              contenu:
                  "Prévoir environ 1 heure pour l'intervention. Merci d'arriver 10 minutes avant l'heure prévue.",
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: OutlinedButton.icon(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),

                label: const Text(
                  "Annuler ce rendez-vous",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                style:
                    OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                  ),
                ),

                onPressed: () {
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
                                  "Rendez-vous annulé",
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blocInfo({
    required IconData icon,
    required String titre,
    required String contenu,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: CouleursApp.orange,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  titre,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(contenu),
              ],
            ),
          ),
        ],
      ),
    );
  }
}