import 'package:flutter/material.dart';
import 'modules/authentification/connexion_ecran.dart';
import 'modules/accueil/accueil_ecran.dart';
import 'modules/accueil/profil_ecran.dart';
import 'modules/vehicules/liste_vehicules_ecran.dart';
import 'modules/vehicules/formulaire_vehicule_ecran.dart';
import 'modules/vehicules/detail_vehicule_ecran.dart';
import 'modules/rendez_vous/liste_rendez_vous_ecran.dart';
import 'modules/rendez_vous/detail_rendez_vous_ecran.dart';
import 'modules/rendez_vous/reservation_rendez_vous_ecran.dart';
import 'modules/rendez_vous/confirmation_rendez_vous_ecran.dart';
import 'modules/navigation/navigation_principale.dart';


void main() {
  runApp(const OasMobile());
}

class OasMobile extends StatelessWidget {
  const OasMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const NavigationPrincipale(),
      //home: const ConfirmationRendezVousEcran(),
      //home: const ReservationRendezVousEcran(),
      //home: const DetailRendezVousEcran(),
      //home: const ListeRendezVousEcran(),
      //home: const DetailVehiculeEcran(),
      //home: const FormulaireVehiculeEcran(),
      //home: const ListeVehiculesEcran(),
      //home: ProfilEcran(),
      //home: AccueilEcran(),
      home: ConnexionEcran(),
    );
  }
}