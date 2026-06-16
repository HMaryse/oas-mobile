import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/bouton_principal.dart';
import '../../core/widgets/champ_texte_personnalise.dart';

class InscriptionEcran extends StatelessWidget {
  const InscriptionEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: CouleursApp.bleuFonce),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                "Créer un compte",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: CouleursApp.bleuFonce,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Rejoignez le portail client OAS",
                style: TextStyle(color: CouleursApp.grisTexte),
              ),

              const SizedBox(height: 30),

              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Prénom",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Nom",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: ChampTextePersonnalise(
                      hintText: "Moussa",
                      icone: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChampTextePersonnalise(
                      hintText: "Diop",
                      icone: Icons.person_outline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                "Adresse e-mail",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 8),

              ChampTextePersonnalise(
                hintText: "moussa.diop@email.sn",
                icone: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              const Text(
                "Téléphone",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 8),

              ChampTextePersonnalise(
                hintText: "+221 77 123 45 67",
                icone: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 16),

              const Text(
                "Mot de passe",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 8),

              ChampTextePersonnalise(
                hintText: "********",
                icone: Icons.lock_outline,
                motDePasse: true,
              ),

              const SizedBox(height: 16),

              const Text(
                "Confirmer le mot de passe",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 8),

              ChampTextePersonnalise(
                hintText: "********",
                icone: Icons.lock_outline,
                motDePasse: true,
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Votre matricule client sera généré automatiquement après validation de votre inscription.",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              BoutonPrincipal(
                texte: "S'inscrire",
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Inscription simulée")),
                  );
                },
              ),

              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Déjà un compte ? Se connecter",
                    style: TextStyle(color: CouleursApp.orange),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
