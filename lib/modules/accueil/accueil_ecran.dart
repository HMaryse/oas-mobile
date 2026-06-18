import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/bouton_action_rapide.dart';
import '../../core/widgets/carte_statistique.dart';
import '../../core/widgets/element_menu.dart';
import '../client/models/client_model.dart';
import '../client/repository/client_repository.dart';
import '../factures/facture_ecran.dart';
import '../proformas/liste_proformas_ecran.dart';
import '../rendez_vous/reservation_rendez_vous_ecran.dart';
import '../reparations/reparation_ecran.dart';
import '../vehicules/formulaire_vehicule_ecran.dart';

class AccueilEcran extends StatefulWidget {
  const AccueilEcran({super.key});

  @override
  State<AccueilEcran> createState() => _AccueilEcranState();
}

class _AccueilEcranState extends State<AccueilEcran> {
  final ClientRepository clientRepository = ClientRepository();

  ClientModel? client;

  bool chargement = true;

  @override
  void initState() {
    super.initState();
    chargerProfil();
  }

  Future<void> chargerProfil() async {
    try {
      final resultat = await clientRepository.getProfil();

      setState(() {
        client = resultat;
        chargement = false;
      });
    } catch (e) {
      setState(() {
        chargement = false;
      });

      debugPrint("Erreur chargement profil : $e");
    }
  }

  String getInitiales() {
    if (client == null) return "";

    final prenom = client!.firstName.isNotEmpty ? client!.firstName[0] : "";

    final nom = client!.lastName.isNotEmpty ? client!.lastName[0] : "";

    return "$prenom$nom".toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    if (chargement) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: chargerProfil,

          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: const Color(0xFF173B6D),

                        child: Text(
                          getInitiales(),

                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "${client?.firstName ?? ''} ${client?.lastName ?? ''}",

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              client?.phone ?? "",

                              style: const TextStyle(color: Colors.grey),
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

                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Text(
                          client?.matricule ?? "",

                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    CarteStatistique(
                      icone: Icons.calendar_today,
                      valeur: "0",
                      titre: "RDV actifs",
                    ),

                    const SizedBox(width: 10),

                    CarteStatistique(
                      icone: Icons.handyman,
                      valeur: "0",
                      titre: "En réparation",
                    ),

                    const SizedBox(width: 10),

                    CarteStatistique(
                      icone: Icons.receipt,
                      valeur: "0",
                      titre: "Factures",
                    ),
                  ],
                ),

                const SizedBox(height: 20),

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
                            builder: (_) => const ReservationRendezVousEcran(),
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
                            builder: (_) => const FormulaireVehiculeEcran(),
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

                const SizedBox(height: 10),

                ElementMenu(
                  icone: Icons.payments_outlined,

                  titre: "Consulter mes proformas",

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ListeProformasEcran()),
                    );
                  },
                ),

                const SizedBox(height: 9),

                ElementMenu(
                  icone: Icons.build_outlined,
                  titre: "Consulter mes réparations",

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReparationsEcran(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 9),

                ElementMenu(
                  icone: Icons.receipt_long_outlined,

                  titre: "Consulter mes factures",

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FacturesEcran()),
                    );
                  },
                ),


                const SizedBox(height: 9),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
