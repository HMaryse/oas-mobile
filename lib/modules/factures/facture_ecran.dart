import 'package:flutter/material.dart';

class FacturesEcran extends StatelessWidget {
  const FacturesEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Factures',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}