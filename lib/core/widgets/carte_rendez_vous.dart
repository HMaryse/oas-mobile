import 'package:flutter/material.dart';

class CarteRendezVous extends StatelessWidget {
  final String date;
  final String heure;
  final String vehicule;
  final String motif;
  final String statut;

  const CarteRendezVous({
    super.key,
    required this.date,
    required this.heure,
    required this.vehicule,
    required this.motif,
    required this.statut,
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [

          Row(
            children: [

              Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Text(
                  date,
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      heure,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      vehicule,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color:
                      couleurStatut().withOpacity(.15),
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  statut,
                  style: TextStyle(
                    color: couleurStatut(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              motif,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Détails",
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Annuler",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}