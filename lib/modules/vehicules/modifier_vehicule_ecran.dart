import 'package:flutter/material.dart';

import 'formulaire_vehicule_ecran.dart';

class ModifierVehiculeEcran extends StatelessWidget {
  const ModifierVehiculeEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormulaireVehiculeEcran(
      modeModification: true,
    );
  }
}