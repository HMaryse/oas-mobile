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

          borderRadius:
              BorderRadius.circular(10),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.06,
              ),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Icon(
              icone,
              size: 24,
              color: Colors.orange,
            ),

            const SizedBox(height: 12),

            Text(
              valeur,
              style: const TextStyle(
                fontWeight:
                    FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              titre,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
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