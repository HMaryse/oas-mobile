import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../authentification/connexion_ecran.dart';

class ProfilEcran extends StatelessWidget {
  const ProfilEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "Mon Profil",
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: CouleursApp.bleuFonce,

                    child: Text(
                      "HO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    "Hilly OKANA",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: const Text(
                      "CLT-00042",
                      style: TextStyle(
                        color: CouleursApp.orange,
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
                Expanded(
                  child: _statCard(
                    Icons.directions_car,
                    "2",
                    "Véhicules",
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statCard(
                    Icons.calendar_month,
                    "3",
                    "RDV",
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _statCard(
                    Icons.build,
                    "5",
                    "Réparations",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _infoTile(
              Icons.person_outline,
              "Nom complet",
              "Hilly OKANA",
            ),

            _infoTile(
              Icons.email_outlined,
              "Adresse e-mail",
              "hilly.okana@email.sn",
            ),

            _infoTile(
              Icons.phone_outlined,
              "Téléphone",
              "+221 77 123 45 67",
            ),

            _infoTile(
              Icons.location_on_outlined,
              "Adresse",
              "Sacré-Cœur 3, Dakar",
            ),

            _infoTile(
              Icons.verified_user_outlined,
              "Client depuis",
              "15 Juin 2025",
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Modification du profil à venir",
                      ),
                    ),
                  );
                },

                icon: const Icon(Icons.edit_outlined),

                label: const Text(
                  "Modifier mes informations",
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: CouleursApp.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: OutlinedButton.icon(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),

                label: const Text(
                  "Déconnexion",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),

                onPressed: () {
                  showDialog(
                    context: context,

                    builder: (_) => AlertDialog(
                      title: const Text(
                        "Déconnexion",
                      ),

                      content: const Text(
                        "Voulez-vous vraiment vous déconnecter ?",
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Non"),
                        ),

                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),

                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const ConnexionEcran(),
                              ),
                              (route) => false,
                            );
                          },

                          child: const Text(
                            "Oui",
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _statCard(
    IconData icon,
    String valeur,
    String titre,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            color: CouleursApp.orange,
          ),

          const SizedBox(height: 8),

          Text(
            valeur,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            titre,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _infoTile(
    IconData icon,
    String titre,
    String valeur,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: CouleursApp.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),

            child: Icon(
              icon,
              color: CouleursApp.orange,
            ),
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
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  valeur,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}