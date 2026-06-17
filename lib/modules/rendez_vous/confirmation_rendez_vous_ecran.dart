import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/bouton_principal.dart';
import 'models/rendez_vous.dart';

class ConfirmationRendezVousEcran extends StatelessWidget {
  final RendezVous rendezVous;

  const ConfirmationRendezVousEcran({
    super.key,
    required this.rendezVous,
  });

  String libelleStatut() {
    switch (rendezVous.statut) {
      case "EN_ATTENTE":
        return "En attente";

      case "CONFIRME":
        return "Confirmé";

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

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 120,
                height: 120,

                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.green.shade700,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Demande envoyée !",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: CouleursApp.bleuFonce,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Votre demande de rendez-vous a bien été enregistrée.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: Column(
                  children: [
                    _LigneResume(
                      titre: "Date",
                      valeur:
                          "${date.day}/${date.month}/${date.year}",
                    ),

                    const Divider(),

                    _LigneResume(
                      titre: "Heure",
                      valeur:
                          "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}",
                    ),

                    const Divider(),

                    _LigneResume(
                      titre: "Véhicule",
                      valeur:
                          rendezVous
                              .vehiculeImmatriculation,
                    ),

                    const Divider(),

                    _LigneResume(
                      titre: "Statut",
                      valeur: libelleStatut(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color:
                      Colors.orange.shade50,
                  borderRadius:
                      BorderRadius.circular(
                          12),
                ),

                child: const Text(
                  "L'atelier vous contactera pour confirmer votre rendez-vous.",
                  textAlign: TextAlign.center,
                ),
              ),

              const Spacer(),

              BoutonPrincipal(
                texte:
                    "Retour à l'accueil",

                onPressed: () {
                  Navigator.popUntil(
                    context,
                    (route) =>
                        route.isFirst,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LigneResume extends StatelessWidget {
  final String titre;
  final String valeur;

  const _LigneResume({
    required this.titre,
    required this.valeur,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titre,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),

        Text(
          valeur,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}