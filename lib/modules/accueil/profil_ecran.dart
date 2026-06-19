import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../authentification/connexion_ecran.dart';
import 'models/profil_model.dart';
import 'repository/profil_repository.dart';
import '../parametres/parametres_ecran.dart';

class ProfilEcran extends StatefulWidget {
  const ProfilEcran({super.key});

  @override
  State<ProfilEcran> createState() =>
      _ProfilEcranState();
}

class _ProfilEcranState
    extends State<ProfilEcran> {

  final ProfilRepository repository =
      ProfilRepository();

  ProfilModel? profil;

  bool chargement = true;

  @override
  void initState() {
    super.initState();
    chargerProfil();
  }

  Future<void> chargerProfil() async {
    try {

      final resultat =
          await repository.getProfil();

      setState(() {
        profil = resultat;
        chargement = false;
      });

    } catch (e) {

      setState(() {
        chargement = false;
      });

      debugPrint(
        "Erreur profil : $e",
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    if (chargement) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (profil == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Impossible de charger le profil",
          ),
        ),
      );
    }

    final initiales =
        "${profil!.firstName.isNotEmpty ? profil!.firstName[0] : ''}"
        "${profil!.lastName.isNotEmpty ? profil!.lastName[0] : ''}"
            .toUpperCase();

    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

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

  actions: [
    IconButton(
      icon: const Icon(
        Icons.settings_outlined,
        color: CouleursApp.bleuFonce,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>const ParametresEcran(),
          ),
        );
      },
    ),
  ],
),

      body: RefreshIndicator(
        onRefresh: chargerProfil,

        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(),

          padding:
              const EdgeInsets.all(16),

          child: Column(
            children: [

              Container(
  width: double.infinity,

  padding: const EdgeInsets.all(18),

  decoration: BoxDecoration(
  gradient: const LinearGradient(
    colors: [
      CouleursApp.bleuFonce,
      Color(0xFF1E3A8A),
    ],
  ),

  borderRadius:
      BorderRadius.circular(12),

  boxShadow: [
    BoxShadow(
      color:
          Colors.black.withOpacity(
        0.08,
      ),
      blurRadius: 12,
      offset: const Offset(
        0,
        4,
      ),
    ),
  ],
),

  child: Row(
    children: [

      Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              "${profil!.firstName} ${profil!.lastName}",

              style:
                  const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
                color:
                    Colors.white,
              ),
            ),

            const SizedBox(
              height: 4,
            ),

            Text(
              profil!.email,

              style:
                  const TextStyle(
                color:
                    CouleursApp.grisTexte,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),

      Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),

        decoration:
            BoxDecoration(
          color: CouleursApp.orange
              .withOpacity(0.12),

          borderRadius:
              BorderRadius.circular(
            20,
          ),
        ),

        child: Text(
          profil!.matricule,

          style:
              const TextStyle(
            color:
                CouleursApp.orange,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
),
              const SizedBox(
                  height: 20),

              _infoTile(
                Icons.person_outline,
                "Nom complet",
                "${profil!.firstName} ${profil!.lastName}",
              ),

              _infoTile(
                Icons.email_outlined,
                "Adresse e-mail",
                profil!.email,
              ),

              _infoTile(
                Icons.phone_outlined,
                "Téléphone",
                profil!.phone,
              ),

              _infoTile(
                Icons.badge_outlined,
                "Nom d'utilisateur",
                profil!.username,
              ),

              _infoTile(
                Icons.confirmation_number_outlined,
                "Matricule",
                profil!.matricule,
              ),

              _infoTile(
                Icons.verified_user_outlined,
                "Type",
                "CLIENT",
              ),

              Container(
  margin:
      const EdgeInsets.only(
          bottom: 12),

  decoration: BoxDecoration(
    color: Colors.white,

    borderRadius:
        BorderRadius.circular(
            12),

    boxShadow: [
      BoxShadow(
        color:
            Colors.black.withOpacity(
                0.05),
        blurRadius: 8,
        offset:
            const Offset(0, 2),
      ),
    ],
  ),

  child: ListTile(
    leading: Container(
      padding:
          const EdgeInsets.all(
              10),

      decoration:
          BoxDecoration(
        color:
            CouleursApp.orange
                .withOpacity(
                    0.1),

        borderRadius:
            BorderRadius
                .circular(
                    10),
      ),

      child: const Icon(
        Icons.settings_outlined,
        color:
            CouleursApp.orange,
      ),
    ),

    title: const Text(
      "Paramètres",
      style: TextStyle(
        fontWeight:
            FontWeight.w600,
      ),
    ),

    subtitle: const Text(
      "Préférences et sécurité",
    ),

    trailing: const Icon(
      Icons.chevron_right,
    ),

    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const ParametresEcran(),
        ),
      );
    },
  ),
),
              const SizedBox(
                  height: 12),

              SizedBox(
                width:
                    double.infinity,
                height: 55,

                child:
                    OutlinedButton.icon(
                  icon: const Icon(
                    Icons.logout,
                    color:
                        Colors.red,
                  ),

                  label: const Text(
                    "Déconnexion",
                    style:
                        TextStyle(
                      color:
                          Colors.red,
                      fontWeight:
                          FontWeight
                              .w600,
                    ),
                  ),

                  style:
                      OutlinedButton
                          .styleFrom(
                    side:
                        const BorderSide(
                      color:
                          Colors.red,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  14),
                    ),
                  ),

                  onPressed: () {

                    showDialog(
                      context:
                          context,

                      builder:
                          (_) =>
                              AlertDialog(
                        title:
                            const Text(
                          "Déconnexion",
                        ),

                        content:
                            const Text(
                          "Voulez-vous vraiment vous déconnecter ?",
                        ),

                        actions: [

                          TextButton(
                            onPressed:
                                () {
                              Navigator.pop(
                                  context);
                            },

                            child:
                                const Text(
                              "Non",
                            ),
                          ),

                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.red,
                            ),

                            onPressed:
                                () {

                              Navigator.pushAndRemoveUntil(
                                context,

                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          const ConnexionEcran(),
                                ),

                                (
                                  route,
                                ) =>
                                    false,
                              );
                            },

                            child:
                                const Text(
                              "Oui",
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                  height: 20),
            ],
          ),
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
      margin:
          const EdgeInsets.only(
              bottom: 12),

      padding:
          const EdgeInsets.all(16),

      decoration: BoxDecoration(
  color: Colors.white,

  borderRadius:
      BorderRadius.circular(
          12),

  boxShadow: [
    BoxShadow(
      color:
          Colors.black.withOpacity(
              0.05),
      blurRadius: 8,
      offset:
          const Offset(0, 2),
    ),
  ],
),

      child: Row(
        children: [

          Container(
            padding:
                const EdgeInsets.all(
                    10),

            decoration:
                BoxDecoration(
              color:
                  CouleursApp.orange
                      .withOpacity(
                          0.1),

              borderRadius:
                  BorderRadius
                      .circular(10),
            ),

            child: Icon(
              icon,
              color:
                  CouleursApp.orange,
            ),
          ),

          const SizedBox(
              width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  titre,
                  style:
                      const TextStyle(
                    color:
                        Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(
                    height: 4),

                Text(
                  valeur,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight
                            .w600,
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