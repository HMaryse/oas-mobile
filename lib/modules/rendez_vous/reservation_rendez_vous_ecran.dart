import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/bouton_principal.dart';

class ReservationRendezVousEcran extends StatefulWidget {
  const ReservationRendezVousEcran({super.key});

  @override
  State<ReservationRendezVousEcran> createState() =>
      _ReservationRendezVousEcranState();
}

class _ReservationRendezVousEcranState
    extends State<ReservationRendezVousEcran> {

  String? vehiculeSelectionne;

  final motifController =
      TextEditingController();

  final List<String> vehicules = [
    "Toyota Hilux (DK-8849-B)",
    "Renault Clio IV (DK-2208-CD)"
  ];

  DateTime dateChoisie =
      DateTime.now();

  TimeOfDay heureChoisie =
      const TimeOfDay(
    hour: 9,
    minute: 30,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,

        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Annuler",
            style: TextStyle(
              color: CouleursApp.orange,
            ),
          ),
        ),

        centerTitle: true,

        title: const Text(
          "Nouveau Rendez-vous",
          style: TextStyle(
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

            const Text("Véhicule"),

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
                          dateChoisie =
                              date;
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
                                    12),
                      ),

                      child: Text(
                        "${dateChoisie.day}/${dateChoisie.month}/${dateChoisie.year}",
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
                                    12),
                      ),

                      child: Text(
                        heureChoisie
                            .format(
                                context),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Motif de la visite",
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: motifController,
              maxLines: 4,

              decoration: _decoration(
                hint:
                    "Changement plaquettes de frein",
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
                        12),
              ),

              child: const Text(
                "Votre demande sera confirmée par l'atelier sous 24h.",
              ),
            ),

            const SizedBox(height: 30),

            BoutonPrincipal(
              texte: "Réserver",
              onPressed: () {},
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child:
                    const Text("Annuler"),
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
            BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),

        borderSide:
            const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),

        borderSide:
            const BorderSide(
          color: CouleursApp.orange,
          width: 2,
        ),
      ),
    );
  }
}