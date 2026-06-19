import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'repository/parametres_repository.dart';
import '../../core/services/storage_service.dart';
import 'repository/parametres_repository.dart';

class ChangerMotDePasseEcran
    extends StatefulWidget {

  const ChangerMotDePasseEcran({
    super.key,
  });

  @override
  State<ChangerMotDePasseEcran>
      createState() =>
          _ChangerMotDePasseEcranState();
}

class _ChangerMotDePasseEcranState
    extends State<
        ChangerMotDePasseEcran> {

  final repository =
      ParametresRepository();

  final ancienController =
      TextEditingController();

  final nouveauController =
      TextEditingController();

  final confirmationController =
      TextEditingController();

  bool chargement = false;

  Future<void> changerMotDePasse()
      async {

    if (ancienController.text
            .trim()
            .isEmpty ||
        nouveauController.text
            .trim()
            .isEmpty ||
        confirmationController.text
            .trim()
            .isEmpty) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Tous les champs sont obligatoires",
          ),
        ),
      );

      return;
    }

    if (nouveauController.text !=
        confirmationController.text) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Les mots de passe ne correspondent pas",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {
        chargement = true;
      });

      final username =
            await StorageService.getUsername();

        if (username == null) {
          throw Exception(
            'Utilisateur non connecté',
          );
        }

      await repository
          .changerMotDePasse(
          username: username,
          ancienMotDePasse:
              ancienController.text.trim(),
          nouveauMotDePasse:
              nouveauController.text.trim(),
        );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            "Mot de passe modifié avec succès",
          ),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

      setState(() {
        chargement = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

      appBar: AppBar(
        title: const Text(
          "Changer mot de passe",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),

        child: Column(
          children: [

            TextField(
              controller:
                  ancienController,

              obscureText: true,

              decoration:
                  const InputDecoration(
                labelText:
                    "Ancien mot de passe",
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextField(
              controller:
                  nouveauController,

              obscureText: true,

              decoration:
                  const InputDecoration(
                labelText:
                    "Nouveau mot de passe",
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextField(
              controller:
                  confirmationController,

              obscureText: true,

              decoration:
                  const InputDecoration(
                labelText:
                    "Confirmer le mot de passe",
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            SizedBox(
              width:
                  double.infinity,

              height: 52,

              child:
                  ElevatedButton(
                onPressed:
                    chargement
                        ? null
                        : changerMotDePasse,

                child: chargement
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Enregistrer",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}