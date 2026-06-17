import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/bouton_principal.dart';
import '../../core/widgets/champ_texte_personnalise.dart';
import 'repository/auth_repository.dart';

class InscriptionEcran extends StatefulWidget {
  const InscriptionEcran({super.key});

  @override
  State<InscriptionEcran> createState() =>
      _InscriptionEcranState();
}

class _InscriptionEcranState
    extends State<InscriptionEcran> {

  final AuthRepository authRepository =
      AuthRepository();

  final prenomController =
      TextEditingController();

  final nomController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final telephoneController =
      TextEditingController();

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmationController =
      TextEditingController();

  bool chargement = false;

  Future<void> inscrire() async {

    if (prenomController.text.isEmpty ||
        nomController.text.isEmpty ||
        emailController.text.isEmpty ||
        telephoneController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmationController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez remplir tous les champs",
          ),
        ),
      );

      return;
    }

    if (passwordController.text !=
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

      await authRepository.register(
        firstName:
            prenomController.text.trim(),
        lastName:
            nomController.text.trim(),
        email:
            emailController.text.trim(),
        phone:
            telephoneController.text.trim(),
        username:
            usernameController.text.trim(),
        password:
            passwordController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Compte créé avec succès",
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

      if (mounted) {
        setState(() {
          chargement = false;
        });
      }
    }
  }

  @override
  void dispose() {

    prenomController.dispose();
    nomController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmationController.dispose();

    super.dispose();
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

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color:
                CouleursApp.bleuFonce,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 24,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                "Créer un compte",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      CouleursApp.bleuFonce,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Rejoignez le portail client OAS",
                style: TextStyle(
                  color:
                      CouleursApp.grisTexte,
                ),
              ),

              const SizedBox(height: 30),

              const Row(
                children: [

                  Expanded(
                    child: Text(
                      "Prénom",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      "Nom",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [

                  Expanded(
                    child:
                        ChampTextePersonnalise(
                      controller:
                          prenomController,
                      hintText: "Maryse",
                      icone: Icons
                          .person_outline,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child:
                        ChampTextePersonnalise(
                      controller:
                          nomController,
                      hintText: "Okana",
                      icone: Icons
                          .person_outline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                "Adresse e-mail",
                style: TextStyle(
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              ChampTextePersonnalise(
                controller:
                    emailController,
                hintText:
                    "maryse@email.com",
                icone:
                    Icons.email_outlined,
                keyboardType:
                    TextInputType
                        .emailAddress,
              ),

              const SizedBox(height: 16),

              const Text(
                "Téléphone",
                style: TextStyle(
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              ChampTextePersonnalise(
                controller:
                    telephoneController,
                hintText:
                    "+221 77 123 45 67",
                icone:
                    Icons.phone_outlined,
                keyboardType:
                    TextInputType.phone,
              ),

              const SizedBox(height: 16),

              const Text(
                "Nom d'utilisateur",
                style: TextStyle(
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              ChampTextePersonnalise(
                controller:
                    usernameController,
                hintText:
                    "maryse.okana",
                icone:
                    Icons.person_outline,
              ),

              const SizedBox(height: 16),

              const Text(
                "Mot de passe",
                style: TextStyle(
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              ChampTextePersonnalise(
                controller:
                    passwordController,
                hintText: "********",
                icone:
                    Icons.lock_outline,
                motDePasse: true,
              ),

              const SizedBox(height: 16),

              const Text(
                "Confirmer le mot de passe",
                style: TextStyle(
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              ChampTextePersonnalise(
                controller:
                    confirmationController,
                hintText: "********",
                icone:
                    Icons.lock_outline,
                motDePasse: true,
              ),

              const SizedBox(height: 20),

              Container(
                padding:
                    const EdgeInsets.all(
                        16),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.blue.shade50,
                  borderRadius:
                      BorderRadius
                          .circular(12),
                ),

                child: const Row(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [

                    Icon(
                      Icons.info_outline,
                      color:
                          Colors.blue,
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "Le matricule client est généré automatiquement par OAS.",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              chargement
                  ? const Center(
                      child:
                          CircularProgressIndicator(),
                    )
                  : BoutonPrincipal(
                      texte:
                          "S'inscrire",
                      onPressed:
                          inscrire,
                    ),

              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context);
                  },
                  child: const Text(
                    "Déjà un compte ? Se connecter",
                    style: TextStyle(
                      color:
                          CouleursApp
                              .orange,
                    ),
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