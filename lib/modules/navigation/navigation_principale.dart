import 'package:flutter/material.dart';

import '../accueil/accueil_ecran.dart';
import '../accueil/profil_ecran.dart';
import '../rendez_vous/liste_rendez_vous_ecran.dart';
import '../vehicules/liste_vehicules_ecran.dart';
import 'menu_lateral.dart';

class NavigationPrincipale extends StatefulWidget {
  const NavigationPrincipale({super.key});

  @override
  State<NavigationPrincipale> createState() =>
      _NavigationPrincipaleState();
}

class _NavigationPrincipaleState
    extends State<NavigationPrincipale> {

  int indexSelectionne = 0;

  final pages = const [
    AccueilEcran(),
    ListeVehiculesEcran(),
    ListeRendezVousEcran(),
    ProfilEcran(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuLateral(),

      body: pages[indexSelectionne],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexSelectionne,

        onTap: (index) {
          setState(() {
            indexSelectionne = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Accueil",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: "Véhicules",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "RDV",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}