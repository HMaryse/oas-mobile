import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../authentification/connexion_ecran.dart';
import 'changer_mot_de_passe_ecran.dart';
import '../accueil/profil_ecran.dart';

class ParametresEcran extends StatelessWidget {
  const ParametresEcran({
    super.key,
  });

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
          "Paramètres",
          style: TextStyle(
            color:
                CouleursApp.bleuFonce,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding:
            const EdgeInsets.all(16),

        children: [

          Container(
            padding:
                const EdgeInsets.all(20),

            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(
                colors: [
                  CouleursApp
                      .bleuFonce,
                  Color(
                    0xFF1E3A8A,
                  ),
                ],
              ),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(
                    0.08,
                  ),
                  blurRadius: 12,
                  offset:
                      const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),

            child: const Row(
              children: [

                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      Colors.white,

                  child: Icon(
                    Icons.settings,
                    color:
                        CouleursApp
                            .bleuFonce,
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Text(
                        "Mon compte",
                        style:
                            TextStyle(
                          color:
                              Colors
                                  .white,
                          fontSize:
                              18,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),

                      SizedBox(
                        height: 4,
                      ),

                      Text(
                        "Gestion de votre espace client",
                        style:
                            TextStyle(
                          color:
                              Colors
                                  .white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _sectionTitre(
            "Compte",
          ),

          const SizedBox(
            height: 10,
          ),

          _tuile(
            context,
            icone:
                Icons.person_outline,
            titre:
                "Mon profil",
            sousTitre:
                "Consulter mes informations",
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const ProfilEcran(),
              ),
            );
            },
          ),

          _tuile(
            context,
            icone:
                Icons.lock_outline,
            titre:
                "Changer le mot de passe",
            sousTitre:
                "Mettre à jour votre mot de passe",
            onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const ChangerMotDePasseEcran(),
              ),
            );
          },
          ),

          const SizedBox(
            height: 24,
          ),

          _sectionTitre(
            "Notifications",
          ),

          const SizedBox(
            height: 10,
          ),

          _tuile(
            context,
            icone:
                Icons.notifications_outlined,
            titre:
                "Notifications",
            sousTitre:
                "Voir toutes mes notifications",
            onTap: () {},
          ),

          const SizedBox(
            height: 24,
          ),

          _sectionTitre(
            "Application",
          ),

          const SizedBox(
            height: 10,
          ),

          _tuile(
            context,
            icone:
                Icons.info_outline,
            titre:
                "À propos",
            sousTitre:
                "Version 1.0.0",
            onTap: () {},
          ),

          const SizedBox(
            height: 32,
          ),

          SizedBox(
            height: 52,

            child:
                OutlinedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ConnexionEcran(),
                  ),
                  (
                    route,
                  ) =>
                      false,
                );
              },

              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),

              label: const Text(
                "Déconnexion",
                style: TextStyle(
                  color:
                      Colors.red,
                ),
              ),

              style:
                  OutlinedButton
                      .styleFrom(
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _sectionTitre(
    String titre,
  ) {
    return Text(
      titre.toUpperCase(),

      style: const TextStyle(
        fontWeight:
            FontWeight.bold,
        color:
            CouleursApp.grisTexte,
        fontSize: 12,
        letterSpacing: 0.8,
      ),
    );
  }

  static Widget _tuile(
    BuildContext context, {
    required IconData icone,
    required String titre,
    required String sousTitre,
    required VoidCallback onTap,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          12,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(
              0.05,
            ),
            blurRadius: 8,
            offset:
                const Offset(
              0,
              2,
            ),
          ),
        ],
      ),

      child: ListTile(
        leading: Icon(
          icone,
          color:
              CouleursApp.orange,
        ),

        title: Text(
          titre,
        ),

        subtitle: Text(
          sousTitre,
        ),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: onTap,
      ),
    );
  }
}