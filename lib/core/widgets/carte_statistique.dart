import 'package:flutter/material.dart';

class CarteStatistique extends StatelessWidget {
  final IconData icone;
  final String valeur;
  final String titre;

  const CarteStatistique({
    super.key,
    required this.icone,
    required this.valeur,
    required this.titre,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Icon(
              icone,
              size: 22,
              color: Colors.orange,
            ),

            const SizedBox(height: 10),

            Text(
              valeur,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            Text(
              titre,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}