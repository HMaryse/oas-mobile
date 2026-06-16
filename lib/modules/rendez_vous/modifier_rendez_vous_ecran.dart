import 'package:flutter/material.dart';
import 'reservation_rendez_vous_ecran.dart';

class ModifierRendezVousEcran extends StatelessWidget {
  const ModifierRendezVousEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReservationRendezVousEcran(
      modeModification: true,
    );
  }
}