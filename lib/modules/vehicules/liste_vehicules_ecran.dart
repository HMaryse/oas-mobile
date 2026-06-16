import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/carte_vehicule.dart';

import 'ajouter_vehicule_ecran.dart';
import 'modifier_vehicule_ecran.dart';
import 'detail_vehicule_ecran.dart';

class ListeVehiculesEcran extends StatelessWidget {
  const ListeVehiculesEcran({super.key});

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

        title: const Text(
          "Mes Véhicules",
          style: TextStyle(
            color: CouleursApp.bleuFonce,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: CouleursApp.orange,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const AjouterVehiculeEcran(),
                ),
              );
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          /// RESUME

          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Row(
              children: [

                Icon(
                  Icons.directions_car,
                  color: CouleursApp.orange,
                ),

                SizedBox(width: 10),

                Text(
                  "2 véhicules enregistrés",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// VEHICULE 1

          CarteVehicule(
            marqueModele: "Toyota Hilux",
            immatriculation: "DK-8849-B",
            annee: "2022",
            kilometrage: "34 000 km",

            onDetails: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const DetailVehiculeEcran(),
                ),
              );
            },

            onModifier: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ModifierVehiculeEcran(),
                ),
              );
            },
          ),

          /// VEHICULE 2

          CarteVehicule(
            marqueModele: "Renault Clio IV",
            immatriculation: "DK-2208-CD",
            annee: "2019",
            kilometrage: "78 500 km",

            onDetails: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const DetailVehiculeEcran(),
                ),
              );
            },

            onModifier: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ModifierVehiculeEcran(),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          /// AJOUTER VEHICULE

          SizedBox(
            width: double.infinity,
            height: 55,

            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const AjouterVehiculeEcran(),
                  ),
                );
              },

              icon: const Icon(
                Icons.add,
                color: CouleursApp.orange,
              ),

              label: const Text(
                "Ajouter un véhicule",
                style: TextStyle(
                  color: CouleursApp.bleuFonce,
                  fontWeight: FontWeight.w600,
                ),
              ),

              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Colors.grey.shade300,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}