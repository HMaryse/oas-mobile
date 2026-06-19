import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/bouton_principal.dart';
import '../vehicules/models/vehicule_model.dart';
import 'repository/vehicule_repository.dart';

class FormulaireVehiculeEcran extends StatefulWidget {
  final bool modeModification;
  final VehiculeModel? vehicule;
  

  const FormulaireVehiculeEcran({
    super.key,
    this.modeModification = false,
    this.vehicule,
  });

  @override
  State<FormulaireVehiculeEcran> createState() =>
      _FormulaireVehiculeEcranState();
}

class _FormulaireVehiculeEcranState
    extends State<FormulaireVehiculeEcran> {

  final modeleController = TextEditingController();
  final marqueController = TextEditingController();
  final immatriculationController =
      TextEditingController();
  final kilometrageController =
      TextEditingController();
  final numeroChassisController =
      TextEditingController();

  String? anneeSelectionnee;
  final VehiculeRepository repository =
    VehiculeRepository();

bool chargement = false;


  final List<String> annees = List.generate(
    26,
    (index) => (2025 - index).toString(),
  );

  Future<void> enregistrerVehicule() async {

  if (marqueController.text.trim().isEmpty ||
      anneeSelectionnee == null ||
      modeleController.text.isEmpty ||
      immatriculationController.text.isEmpty ||
      kilometrageController.text.isEmpty ||
      numeroChassisController.text.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Veuillez remplir tous les champs",
        ),
      ),
    );
    return;
  }

  try {

    setState(() {
      chargement = true;
    });

    await repository.ajouterVehicule(
      immatriculation:
          immatriculationController.text.trim(),

      annee:
          int.parse(anneeSelectionnee!),

      modele:
          modeleController.text.trim(),

      marque:
        marqueController.text.trim(),

      kilometrage:
          double.parse(
        kilometrageController.text.trim(),
      ),

      numeroChassis:
          numeroChassisController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Véhicule ajouté avec succès",
        ),
      ),
    );

    Navigator.pop(context, true);

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Erreur : $e",
        ),
      ),
    );

  } finally {

    if (mounted) {
      setState(() {
        chargement = false;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CouleursApp.orange,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: Text(
          widget.modeModification
              ? "Modifier Véhicule"
              : "Ajouter Véhicule",
          style: const TextStyle(
            color: CouleursApp.bleuFonce,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: CouleursApp.orange,
            ),
            onPressed: enregistrerVehicule,
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  Container(
                    width: 70,
                    height: 70,

                    decoration: BoxDecoration(
                      color: CouleursApp.orange
                          .withOpacity(0.1),

                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    child: const Icon(
                      Icons.directions_car,
                      color: CouleursApp.orange,
                      size: 35,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    widget.modeModification
                        ? "Modifier le véhicule"
                        : "Ajouter un véhicule",

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CouleursApp.bleuFonce,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    widget.modeModification
                        ? "Mettez à jour les informations du véhicule"
                        : "Complétez les informations de votre véhicule",

                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color: CouleursApp.grisTexte,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Informations générales",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CouleursApp.bleuFonce,
              ),
            ),

            const SizedBox(height: 16),

            const Text("Marque"),

            const SizedBox(height: 8),

            TextFormField(
              controller: marqueController,

              decoration: _decoration(
                hint: "Ex : Toyota",
              ),
            ),

            const SizedBox(height: 16),

            const Text("Modèle"),

            const SizedBox(height: 8),

            TextFormField(
              controller: modeleController,
              decoration: _decoration(
                hint: "Hilux",
              ),
            ),

            const SizedBox(height: 16),

            const Text("Immatriculation"),

            const SizedBox(height: 8),

            TextFormField(
              controller:
                  immatriculationController,

              decoration: _decoration(
                hint: "DK-8849-B",
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Caractéristiques",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CouleursApp.bleuFonce,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [

                Expanded(
                  child: DropdownButtonFormField<
                      String>(
                    value: anneeSelectionnee,

                    decoration: _decoration(
                      hint: "Année",
                    ),

                    items: annees
                        .map(
                          (annee) =>
                              DropdownMenuItem(
                            value: annee,
                            child: Text(
                              annee,
                            ),
                          ),
                        )
                        .toList(),

                    onChanged: (value) {
                      setState(() {
                        anneeSelectionnee =
                            value;
                      });
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: TextFormField(
                    controller:
                        kilometrageController,

                    keyboardType:
                        TextInputType.number,

                    decoration:
                        _decoration(
                      hint: "Kilométrage",
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              "Numéro de châssis",
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller:
                  numeroChassisController,

              decoration: _decoration(
                hint:
                    "AHR1239840294820",
              ),
            ),

            const SizedBox(height: 30),

            chargement
              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )
              : BoutonPrincipal(
                  texte: "Enregistrer",
                  onPressed:
                      enregistrerVehicule,
                ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text(
                  "Annuler",
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration({
    String? hint,
  }) {
    return InputDecoration(
      hintText: hint,

      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide:
            const BorderSide(
          color: CouleursApp.bordure,
        ),
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide:
            const BorderSide(
          color: CouleursApp.orange,
          width: 2,
        ),
      ),
    );
  }
}