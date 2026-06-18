import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../navigation/navigation_principale.dart';
import 'inscription_ecran.dart';
import 'repository/auth_repository.dart';

class ConnexionEcran extends StatefulWidget {
  const ConnexionEcran({super.key});

  @override
  State<ConnexionEcran> createState() =>
      _ConnexionEcranState();
}

class _ConnexionEcranState
    extends State<ConnexionEcran> {
  bool masquerMotDePasse = true;
  bool chargement = false;

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final AuthRepository authRepository =
      AuthRepository();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> connexion() async {
    try {
      setState(() {
        chargement = true;
      });

      await authRepository.login(
        username:
            usernameController.text.trim(),
        password: passwordController.text,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const NavigationPrincipale(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),

          child: Column(
            children: [
              const SizedBox(height: 20),

              Image.asset(
              "assets/images/logo_oas.jpg",
              height: 90,
            ),

              const SizedBox(height: 25),

              const Text(
                "Orient Auto Service",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: CouleursApp.bleuFonce,
                ),
              ),

              const SizedBox(height: 8),

              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "OAS",
                      style: TextStyle(
                        color:
                            CouleursApp.orange,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          ": Prise de rendez-vous et suivi des reparations",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color:
                            CouleursApp.grisTexte,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              const Align(
                alignment:
                    Alignment.centerLeft,
                child: Text(
                  "Nom d'utilisateur",
                ),
              ),

              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "username",
                    prefixIcon: const Icon(
                      Icons.person_outline,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: CouleursApp.orange,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Align(
                alignment:
                    Alignment.centerLeft,
                child: Text(
                  "Mot de passe",
                ),
              ),

              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: masquerMotDePasse,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          masquerMotDePasse = !masquerMotDePasse;
                        });
                      },
                      icon: Icon(
                        masquerMotDePasse
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: CouleursApp.orange,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

              Align(
                alignment:
                    Alignment.centerRight,

                child: TextButton(
                  onPressed: () {},

                  child: const Text(
                    "Mot de passe oublié ?",
                    style: TextStyle(
                      color:
                          CouleursApp.orange,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed:
                      chargement
                          ? null
                          : connexion,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        CouleursApp.orange,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              12),
                    ),
                  ),

                  child: chargement
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                              CircularProgressIndicator(
                            color:
                                Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Se connecter",
                          style: TextStyle(
                            color:
                                Colors.white,
                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),
                ),
              ),

            

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  const Text(
                    "Nouveau client ? ",
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const InscriptionEcran(),
                        ),
                      );
                    },

                    child: const Text(
                      "Créer un compte",

                      style: TextStyle(
                        color:
                            CouleursApp.orange,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}