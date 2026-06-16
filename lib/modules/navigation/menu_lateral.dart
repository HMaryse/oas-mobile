import 'package:flutter/material.dart';


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