import 'package:flutter/material.dart';

import '../../core/services/storage_service.dart';
import '../../core/theme/couleurs_app.dart';
import 'repository/parametres_repository.dart';

class ChangerMotDePasseEcran extends StatefulWidget {
  const ChangerMotDePasseEcran({
    super.key,
  });

  @override
  State<ChangerMotDePasseEcran> createState() =>
      _ChangerMotDePasseEcranState();
}

class _ChangerMotDePasseEcranState
    extends State<ChangerMotDePasseEcran> {
  final ParametresRepository repository =
      ParametresRepository();

  final ancienController =
      TextEditingController();

  final nouveauController =
      TextEditingController();

  final confirmationController =
      TextEditingController();

  bool chargement = false;

  bool masquerAncien = true;
  bool masquerNouveau = true;
  bool masquerConfirmation = true;

  Future<void> changerMotDePasse() async {
    if (ancienController.text.trim().isEmpty ||
        nouveauController.text.trim().isEmpty ||
        confirmationController.text
            .trim()
            .isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
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
      ScaffoldMessenger.of(context)
          .showSnackBar(
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
          "Utilisateur non connecté",
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

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Mot de passe modifié avec succès",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
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

  InputDecoration decorationChamp({
    required String label,
    required IconData icone,
    required bool masquer,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      labelText: label,

      prefixIcon: Icon(
        icone,
        color: CouleursApp.orange,
      ),

      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(
          masquer
              ? Icons.visibility_off
              : Icons.visibility,
        ),
      ),

      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        borderSide: BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor:
            CouleursApp.grisFond,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "Changer mot de passe",
          style: TextStyle(
            color:
                CouleursApp.bleuFonce,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration:
                  BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    CouleursApp.bleuFonce,
                    Color(0xFF1E3A8A),
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),

              child: const Column(
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 50,
                    color: Colors.white,
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Sécurisez votre compte",
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Mettez à jour votre mot de passe pour protéger votre espace client.",
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding:
                  const EdgeInsets.all(
                16,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black
                            .withOpacity(
                      0.05,
                    ),
                    blurRadius: 10,
                    offset:
                        const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),

              child: Column(
                children: [
                  TextField(
                    controller:
                        ancienController,
                    obscureText:
                        masquerAncien,

                    decoration:
                        decorationChamp(
                      label:
                          "Ancien mot de passe",
                      icone:
                          Icons.lock_outline,
                      masquer:
                          masquerAncien,
                      onToggle: () {
                        setState(() {
                          masquerAncien =
                              !masquerAncien;
                        });
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  TextField(
                    controller:
                        nouveauController,
                    obscureText:
                        masquerNouveau,

                    decoration:
                        decorationChamp(
                      label:
                          "Nouveau mot de passe",
                      icone:
                          Icons.key,
                      masquer:
                          masquerNouveau,
                      onToggle: () {
                        setState(() {
                          masquerNouveau =
                              !masquerNouveau;
                        });
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  TextField(
                    controller:
                        confirmationController,
                    obscureText:
                        masquerConfirmation,

                    decoration:
                        decorationChamp(
                      label:
                          "Confirmer le mot de passe",
                      icone:
                          Icons.verified_user_outlined,
                      masquer:
                          masquerConfirmation,
                      onToggle: () {
                        setState(() {
                          masquerConfirmation =
                              !masquerConfirmation;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: chargement
                    ? null
                    : changerMotDePasse,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      CouleursApp.orange,

                  foregroundColor:
                      Colors.white,

                  elevation: 2,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),
                ),

                child: chargement
                    ? const CircularProgressIndicator(
                        color:
                            Colors.white,
                      )
                    : const Text(
                        "Enregistrer",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}