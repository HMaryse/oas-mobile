import 'package:flutter/material.dart';

class ReparationsEcran extends StatelessWidget {
  const ReparationsEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Réparations',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}