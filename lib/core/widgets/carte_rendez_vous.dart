import 'package:flutter/material.dart';

import '../theme/couleurs_app.dart';

class CarteRendezVous extends StatelessWidget {
  final String date;
  final String heure;
  final String vehicule;
  final String motif;
  final String statut;

  final VoidCallback? onDetails;
  final VoidCallback? onAnnuler;

  const CarteRendezVous({
    super.key,
    required this.date,
    required this.heure,
    required this.vehicule,
    required this.motif,
    required this.statut,
    this.onDetails,
    this.onAnnuler,
  });

  Color couleurStatut() {
    switch (statut) {
      case "Confirmé":
        return Colors.green;

      case "En attente":
        return Colors.orange;

      case "Refusé":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(
        16,
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
                .withOpacity(0.05),
            blurRadius: 8,
            offset:
                const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(
                  12,
                ),
                decoration:
                    BoxDecoration(
                  color: CouleursApp
                      .orange
                      .withOpacity(
                    0.1,
                  ),
                  borderRadius:
                      BorderRadius
                          .circular(
                    10,
                  ),
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color:
                      CouleursApp.orange,
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      vehicule,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight
                                .bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(
                      "$date • $heure",
                      style:
                          const TextStyle(
                        color:
                            Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      couleurStatut()
                          .withOpacity(
                    .15,
                  ),
                  borderRadius:
                      BorderRadius
                          .circular(
                    20,
                  ),
                ),
                child: Text(
                  statut,
                  style: TextStyle(
                    color:
                        couleurStatut(),
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 16,
          ),

          Text(
            motif,
            style:
                const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          Row(
            children: [
              Expanded(
                child:
                    ElevatedButton.icon(
                  onPressed:
                      onDetails,

                  icon: const Icon(
                    Icons
                        .visibility_outlined,
                  ),

                  label: const Text(
                    "Détails",
                  ),

                  style:
                      ElevatedButton
                          .styleFrom(
                    backgroundColor:
                        CouleursApp
                            .orange,
                    foregroundColor:
                        Colors.white,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),
                    ),
                  ),
                ),
              ),

              if (onAnnuler !=
                  null) ...[
                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child:
                      OutlinedButton.icon(
                    onPressed:
                        onAnnuler,

                    icon: const Icon(
                      Icons.close,
                      color:
                          Colors.red,
                    ),

                    label:
                        const Text(
                      "Annuler",
                      style:
                          TextStyle(
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
                            BorderRadius
                                .circular(
                          10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}