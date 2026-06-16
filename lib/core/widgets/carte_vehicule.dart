import 'package:flutter/material.dart';

class CarteVehicule extends StatelessWidget {
  final String marqueModele;
  final String immatriculation;
  final String annee;
  final String kilometrage;

  final VoidCallback? onDetails;
  final VoidCallback? onModifier;

  const CarteVehicule({
    super.key,
    required this.marqueModele,
    required this.immatriculation,
    required this.annee,
    required this.kilometrage,
    this.onDetails,
    this.onModifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        children: [

          /// HEADER
          Row(
            children: [

              Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: const Color(0xFF173B6D),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: const Icon(
                  Icons.directions_car,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      marqueModele,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      immatriculation,

                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// INFOS
          Row(
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Année",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      annee,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Kilométrage",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      kilometrage,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// ACTIONS
          Row(
            children: [

              Expanded(
                child: OutlinedButton(
                  onPressed: onDetails,

                  child: const Text(
                    "Détails",
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton(
                  onPressed: onModifier,

                  child: const Text(
                    "Modifier",
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