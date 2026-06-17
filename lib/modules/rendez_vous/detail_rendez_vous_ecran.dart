import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'models/rendez_vous.dart';

class DetailRendezVousEcran extends StatelessWidget {
  final RendezVous rendezVous;

  const DetailRendezVousEcran({
    super.key,
    required this.rendezVous,
  });

  Color couleurStatut() {
    switch (rendezVous.statut) {
      case "CONFIRME":
        return Colors.green;

      case "EN_ATTENTE":
        return Colors.orange;

      case "REFUSE":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  String libelleStatut() {
    switch (rendezVous.statut) {
      case "CONFIRME":
        return "Confirmé";

      case "EN_ATTENTE":
        return "En attente";

      case "REFUSE":
        return "Refusé";

      default:
        return rendezVous.statut;
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = rendezVous.dateRendezVous;

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
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 40,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "${date.day}/${date.month}/${date.year}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: couleurStatut().withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      libelleStatut(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
              contenu: rendezVous.motif,
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: CouleursApp.orange,

                    child: Icon(
                      Icons.directions_car,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        const Text(
                          "Véhicule",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          rendezVous.vehiculeImmatriculation,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
              titre: "Commentaire",
              contenu:
                  rendezVous.commentaire ??
                  "Aucun commentaire disponible",
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
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                  ),
                ),

                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Fonction d'annulation à connecter au backend",
                      ),
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
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

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
                    fontWeight: FontWeight.bold,
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