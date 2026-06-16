import 'package:flutter/material.dart';
import '../../core/theme/couleurs_app.dart';

class ProfilEcran extends StatelessWidget {
  const ProfilEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,
        title: const Text(
          "Mon Profil",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF173B6D),

              child: Text(
                "HO",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Hilly OKANA",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "Matricule : CLT-00042",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            _infoTile(
              Icons.person_outline,
              "Prénom & Nom",
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
              "Sacré-Coeur 3, Dakar",
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text("Membre depuis 15 Juin 2025"),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: () {},

                child: const Text(
                  "Modifier mes informations",
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: OutlinedButton(
                onPressed: () {},

                child: const Text(
                  "Déconnexion",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoTile(
    IconData icon,
    String titre,
    String valeur,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(icon),

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