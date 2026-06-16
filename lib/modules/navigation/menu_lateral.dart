import 'package:flutter/material.dart';
import '../reparations/reparation_ecran.dart';
import '../factures/facture_ecran.dart';
import '../paiements/recus_paiement_ecran.dart';
import '../parametres/parametres_ecran.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          UserAccountsDrawerHeader(
            accountName:
                const Text("Moussa Diop"),
            accountEmail:
                const Text("CLT-00042"),
            currentAccountPicture:
                const CircleAvatar(
              child: Text("MD"),
            ),
          ),

          ListTile(
            leading:
                const Icon(Icons.home),
            title:
                const Text("Accueil"),
            onTap: () {},
          ),

          ListTile(
            leading:
                const Icon(Icons.directions_car),
            title:
                const Text("Mes véhicules"),
            onTap: () {},
          ),

          ListTile(
            leading:
                const Icon(Icons.calendar_month),
            title:
                const Text("Mes rendez-vous"),
            onTap: () {},
          ),

          ListTile(
            leading:
                const Icon(Icons.person),
            title:
                const Text("Mon profil"),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.build),
            title: const Text("Mes réparations"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReparationsEcran()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text("Mes factures"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FacturesEcran()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.payments),
            title: const Text("Mes reçus de paiement"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RecusPaiementEcran()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Paramètres"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ParametresEcran()),
              );
            },
          ),

          const Spacer(),

          const Divider(),

          ListTile(
            leading:
                const Icon(Icons.logout),
            title:
                const Text("Déconnexion"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}