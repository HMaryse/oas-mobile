import 'package:flutter/material.dart';

import 'formulaire_vehicule_ecran.dart';
import 'models/vehicule_model.dart';

class ModifierVehiculeEcran extends StatelessWidget {
  final VehiculeModel vehicule;

  const ModifierVehiculeEcran({
    super.key,
    required this.vehicule,
  });

  @override
  Widget build(BuildContext context) {
    return FormulaireVehiculeEcran(
      modeModification: true,
      vehicule: vehicule,
    );
  }
}