import 'package:flutter/material.dart';

import 'formulaire_vehicule_ecran.dart';

class AjouterVehiculeEcran extends StatelessWidget {
  const AjouterVehiculeEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormulaireVehiculeEcran(
      modeModification: false,
    );
  }
}