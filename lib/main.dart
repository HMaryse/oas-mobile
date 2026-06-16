import 'package:flutter/material.dart';
import 'modules/authentification/connexion_ecran.dart';

void main() {
  runApp(const OasMobile());
}

class OasMobile extends StatelessWidget {
  const OasMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnexionEcran(),
    );
  }
}