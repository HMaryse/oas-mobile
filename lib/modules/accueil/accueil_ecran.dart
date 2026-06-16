import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/bouton_action_rapide.dart';
import '../../core/widgets/carte_statistique.dart';
import '../../core/widgets/element_menu.dart';
import '../rendez_vous/reservation_rendez_vous_ecran.dart';
import '../vehicules/formulaire_vehicule_ecran.dart';
import '../reparations/reparation_ecran.dart';
import '../factures/facture_ecran.dart';
import '../paiements/recus_paiement_ecran.dart';
import '../parametres/parametres_ecran.dart';

class AccueilEcran extends StatelessWidget {
  const AccueilEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // HEADER

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFF173B6D),

                      child: Text(
                        "HM",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Hilly OKANA",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "+221 77 123 45 67",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),

                      child: const Text(
                        "CLT-00042",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // STATISTIQUES

             Row(
                children:  [
                  CarteStatistique(
                    icone: Icons.calendar_today,
                    valeur: "2",
                    titre: "RDV actifs",
                  ),

                  SizedBox(width: 10),

                  CarteStatistique(
                    icone: Icons.handyman,
                    valeur: "1",
                    titre: "En réparation",
                  ),

                  SizedBox(width: 10),

                  CarteStatistique(
                    icone: Icons.receipt,
                    valeur: "500k",
                    titre: "Solde",
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ACTIONS RAPIDES

              Row(
                  children: [

                    BoutonActionRapide(
                      texte: "Nouveau RDV",
                      icone: Icons.add,
                      couleur: Colors.orange,

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ReservationRendezVousEcran(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(width: 12),

                    BoutonActionRapide(
                      texte: "Ajouter véhicule",
                      icone: Icons.directions_car,
                      couleur: const Color(0xFF173B6D),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const FormulaireVehiculeEcran(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

              const SizedBox(height: 24),

              const Text(
                "ACTIONS RAPIDES",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 12),

              ElementMenu(
                icone: Icons.build_outlined,
                titre: "Consulter mes réparations",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReparationsEcran()),
                  );
                },
              ),

              const SizedBox(height: 10),

              ElementMenu(
                icone: Icons.receipt_long_outlined,
                titre: "Mes factures",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FacturesEcran()),
                  );
                },
              ),

              const SizedBox(height: 10),

              ElementMenu(
                icone: Icons.payments_outlined,
                titre: "Mes reçus de paiement",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RecusPaiementEcran()),
                  );
                },
              ),

              const SizedBox(height: 10),

              ElementMenu(
                icone: Icons.settings_outlined,
                titre: "Paramètres",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ParametresEcran()),
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