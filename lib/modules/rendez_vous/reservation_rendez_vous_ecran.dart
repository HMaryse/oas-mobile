import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/bouton_principal.dart';
import 'confirmation_rendez_vous_ecran.dart';

class ReservationRendezVousEcran extends StatefulWidget {
  final bool modeModification;

  const ReservationRendezVousEcran({
    super.key,
    this.modeModification = false,
  });

  @override
  State<ReservationRendezVousEcran> createState() =>
      _ReservationRendezVousEcranState();
}

class _ReservationRendezVousEcranState
    extends State<ReservationRendezVousEcran> {
  String? vehiculeSelectionne;

  final motifController = TextEditingController();

  final List<String> vehicules = [
    "Toyota Hilux (DK-8849-B)",
    "Renault Clio IV (DK-2208-CD)",
  ];

  DateTime dateChoisie = DateTime.now();

  TimeOfDay heureChoisie = const TimeOfDay(
    hour: 9,
    minute: 30,
  );

  @override
  void initState() {
    super.initState();

    if (widget.modeModification) {
      vehiculeSelectionne =
          "Toyota Hilux (DK-8849-B)";

      motifController.text =
          "Changement plaquettes de frein";
    }
  }

  @override
  void dispose() {
    motifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CouleursApp.orange,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: Text(
          widget.modeModification
              ? "Modifier Rendez-vous"
              : "Nouveau Rendez-vous",
          style: const TextStyle(
            color: CouleursApp.bleuFonce,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: CouleursApp.orange
                          .withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(
                              12),
                    ),

                    child: const Icon(
                      Icons.calendar_month,
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
                          widget.modeModification
                              ? "Modification du rendez-vous"
                              : "Nouvelle demande",
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(
                            height: 4),

                        const Text(
                          "Choisissez un véhicule, une date et un motif.",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Véhicule",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: vehiculeSelectionne,

              decoration: _decoration(),

              items: vehicules
                  .map(
                    (v) => DropdownMenuItem(
                      value: v,
                      child: Text(v),
                    ),
                  )
                  .toList(),

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
                        context: context,
                        initialDate:
                            dateChoisie,
                        firstDate:
                            DateTime.now(),
                        lastDate:
                            DateTime(2030),
                      );

                      if (date != null) {
                        setState(() {
                          dateChoisie = date;
                        });
                      }
                    },

                    child: Container(
                      padding:
                          const EdgeInsets.all(
                              16),

                      decoration:
                          BoxDecoration(
                        color: Colors.white,
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

                const SizedBox(width: 12),

                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final heure =
                          await showTimePicker(
                        context: context,
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
                          const EdgeInsets.all(
                              16),

                      decoration:
                          BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius
                                .circular(
                                    14),
                      ),

                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
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
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: motifController,
              maxLines: 5,

              decoration: _decoration(
                hint:
                    "Décrivez le motif de votre visite",
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding:
                  const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color:
                    Colors.green.shade50,
                borderRadius:
                    BorderRadius.circular(
                        14),
              ),

              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.green,
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
              texte: widget.modeModification
                  ? "Mettre à jour"
                  : "Réserver",

              onPressed: () {
                if (widget
                    .modeModification) {
                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Rendez-vous modifié avec succès",
                      ),
                    ),
                  );

                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ConfirmationRendezVousEcran(),
                    ),
                  );
                }
              },
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
        borderSide: BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide:
            const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide:
            const BorderSide(
          color: CouleursApp.orange,
          width: 2,
        ),
      ),
    );
  }
}