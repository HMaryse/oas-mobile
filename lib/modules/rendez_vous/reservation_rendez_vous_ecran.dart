import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/bouton_principal.dart';
import '../vehicules/models/vehicule_model.dart';
import '../vehicules/repository/vehicule_repository.dart';
import 'confirmation_rendez_vous_ecran.dart';
import 'repository/rendez_vous_repository.dart';

class ReservationRendezVousEcran extends StatefulWidget {
  const ReservationRendezVousEcran({
    super.key,
  });

  @override
  State<ReservationRendezVousEcran> createState() =>
      _ReservationRendezVousEcranState();
}

class _ReservationRendezVousEcranState
    extends State<ReservationRendezVousEcran> {

  final RendezVousRepository rendezVousRepository =
      RendezVousRepository();

  final VehiculeRepository vehiculeRepository =
      VehiculeRepository();

  final motifController =
      TextEditingController();

  List<VehiculeModel> vehicules = [];

  VehiculeModel? vehiculeSelectionne;

  bool chargement = true;

  DateTime dateChoisie = DateTime.now();

  TimeOfDay heureChoisie =
      const TimeOfDay(
    hour: 9,
    minute: 30,
  );

  @override
  void initState() {
    super.initState();
    chargerVehicules();
  }

  Future<void> chargerVehicules() async {
    try {

      final resultat =
          await vehiculeRepository
              .getVehicules();

      setState(() {
        vehicules = resultat;

        if (vehicules.isNotEmpty) {
          vehiculeSelectionne =
              vehicules.first;
        }

        chargement = false;
      });

    } catch (e) {

      setState(() {
        chargement = false;
      });

      debugPrint(
        "Erreur véhicules : $e",
      );
    }
  }

  Future<void> reserver() async {

    if (vehiculeSelectionne == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez sélectionner un véhicule",
          ),
        ),
      );

      return;
    }

    if (motifController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez saisir un motif",
          ),
        ),
      );

      return;
    }

    try {

      final dateRendezVous =
          DateTime(
        dateChoisie.year,
        dateChoisie.month,
        dateChoisie.day,
        heureChoisie.hour,
        heureChoisie.minute,
      );

      await rendezVousRepository
          .creerRendezVous(
        dateRendezVous:
            dateRendezVous,
        motif:
            motifController.text.trim(),
        vehiculeId:
            vehiculeSelectionne!.id,
      );

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "Erreur : $e",
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    motifController.dispose();
    super.dispose();
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

    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor:
            CouleursApp.grisFond,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color:
                CouleursApp.orange,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: const Text(
          "Nouveau Rendez-vous",
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
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(
              padding:
                  const EdgeInsets.all(
                      16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                        18),
              ),

              child: Row(
                children: [

                  Container(
                    padding:
                        const EdgeInsets
                            .all(12),

                    decoration:
                        BoxDecoration(
                      color:
                          CouleursApp
                              .orange
                              .withOpacity(
                                  0.1),

                      borderRadius:
                          BorderRadius
                              .circular(
                                  12),
                    ),

                    child: const Icon(
                      Icons.calendar_month,
                      color:
                          CouleursApp
                              .orange,
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          "Nouvelle demande",
                          style:
                              TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                            fontSize:
                                16,
                          ),
                        ),

                        SizedBox(
                            height: 4),

                        Text(
                          "Choisissez un véhicule, une date et un motif.",
                          style:
                              TextStyle(
                            color:
                                Colors
                                    .grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 24),

            const Text(
              "Véhicule",
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<
                VehiculeModel>(
              value:
                  vehiculeSelectionne,

              decoration:
                  _decoration(),

              items: vehicules.map(
                (vehicule) {

                  return DropdownMenuItem(
                    value: vehicule,

                    child: Text(
                      "${vehicule.marque} ${vehicule.modele} (${vehicule.immatriculation})",
                    ),
                  );
                },
              ).toList(),

              onChanged: (value) {

                setState(() {
                  vehiculeSelectionne =
                      value;
                });
              },
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: InkWell(
                    onTap: () async {

                      final date =
                          await showDatePicker(
                        context:
                            context,

                        initialDate:
                            dateChoisie,

                        firstDate:
                            DateTime.now(),

                        lastDate:
                            DateTime(
                                2030),
                      );

                      if (date != null) {

                        setState(() {
                          dateChoisie =
                              date;
                        });
                      }
                    },

                    child: Container(
                      padding:
                          const EdgeInsets
                              .all(16),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius
                                .circular(
                                    14),
                      ),

                      child: Row(
                        children: [

                          const Icon(
                            Icons
                                .calendar_today,
                            color:
                                CouleursApp
                                    .orange,
                            size: 18,
                          ),

                          const SizedBox(
                              width: 10),

                          Expanded(
                            child: Text(
                              "${dateChoisie.day}/${dateChoisie.month}/${dateChoisie.year}",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    width: 12),

                Expanded(
                  child: InkWell(
                    onTap: () async {

                      final heure =
                          await showTimePicker(
                        context:
                            context,
                        initialTime:
                            heureChoisie,
                      );

                      if (heure != null) {

                        setState(() {
                          heureChoisie =
                              heure;
                        });
                      }
                    },

                    child: Container(
                      padding:
                          const EdgeInsets
                              .all(16),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius
                                .circular(
                                    14),
                      ),

                      child: Row(
                        children: [

                          const Icon(
                            Icons
                                .access_time,
                            color:
                                CouleursApp
                                    .orange,
                            size: 18,
                          ),

                          const SizedBox(
                              width: 10),

                          Expanded(
                            child: Text(
                              heureChoisie
                                  .format(
                                      context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Motif de la visite",
              style: TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller:
                  motifController,
              maxLines: 5,

              decoration:
                  _decoration(
                hint:
                    "Décrivez le motif de votre visite",
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding:
                  const EdgeInsets.all(
                      16),

              decoration: BoxDecoration(
                color:
                    Colors.green
                        .shade50,

                borderRadius:
                    BorderRadius
                        .circular(14),
              ),

              child: const Row(
                children: [

                  Icon(
                    Icons.info_outline,
                    color:
                        Colors.green,
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Votre demande sera analysée et confirmée par l'atelier.",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            BoutonPrincipal(
              texte: "Réserver",
              onPressed: reserver,
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text(
                  "Annuler",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration({
    String? hint,
  }) {
    return InputDecoration(
      hintText: hint,

      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide:
            BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide:
            const BorderSide(
          color:
              Color(0xFFE5E7EB),
        ),
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide:
            const BorderSide(
          color:
              CouleursApp.orange,
          width: 2,
        ),
      ),
    );
  }
}