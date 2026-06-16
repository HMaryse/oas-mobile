import 'package:flutter/material.dart';

class BoutonActionRapide extends StatelessWidget {
  final String texte;
  final IconData icone;
  final Color couleur;
  final VoidCallback? onTap;

  const BoutonActionRapide({
    super.key,
    required this.texte,
    required this.icone,
    required this.couleur,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          height: 75,

          decoration: BoxDecoration(
            color: couleur,
            borderRadius: BorderRadius.circular(14),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                icone,
                color: Colors.white,
              ),

              const SizedBox(height: 8),

              Text(
                texte,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}