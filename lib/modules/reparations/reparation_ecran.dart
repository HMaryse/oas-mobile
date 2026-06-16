import 'package:flutter/material.dart';
import '../../core/theme/couleurs_app.dart';

class ReparationsEcran extends StatefulWidget {
  const ReparationsEcran({super.key});

  @override
  State<ReparationsEcran> createState() => _ReparationsEcranState();
}

class _ReparationsEcranState extends State<ReparationsEcran> {
  int filtreSelectionne = 0;

  final List<String> filtres = [
    "Toutes",
    "En cours",
    "Terminées",
  ];

  final List<Map<String, String>> reparations = [
    {
      "vehicule": "Toyota Hilux - DK-8849-B",
      "description": "Changement plaquettes de frein",
      "date": "12 Juin 2026",
      "montant": "45 000 FCFA",
      "statut": "Terminée",
      "mecanicien": "Garage AutoPro",
    },
    {
      "vehicule": "Renault Clio IV - DK-2208-CD",
      "description": "Diagnostic bruit moteur + réparation courroie",
      "date": "20 Juin 2026",
      "montant": "85 000 FCFA",
      "statut": "En cours",
      "mecanicien": "Atelier Centrale",
    },
    {
      "vehicule": "Toyota Hilux - DK-8849-B",
      "description": "Révision complète 30 000 km",
      "date": "02 Mai 2026",
      "montant": "120 000 FCFA",
      "statut": "Terminée",
      "mecanicien": "Garage AutoPro",
    },
  ];

  List<Map<String, String>> get reparationsFiltrees {
    if (filtreSelectionne == 0) return reparations;
    final filtre = filtres[filtreSelectionne];
    return reparations.where((r) => r["statut"] == filtre).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor: CouleursApp.grisFond,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: CouleursApp.orange),
          onPressed: () => Navigator.pop(context),
        ),

        centerTitle: true,

        title: const Text(
          "Mes Réparations",
          style: TextStyle(
            color: CouleursApp.bleuFonce,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),

              children: [
                // Résumé
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CouleursApp.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.build, color: CouleursApp.orange),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "3 réparations",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "1 en cours • 2 terminées",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Filtres
                SizedBox(
                  height: 42,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filtres.length,
                    itemBuilder: (context, index) {
                      final actif = filtreSelectionne == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(filtres[index]),
                          selected: actif,
                          selectedColor: CouleursApp.bleuFonce,
                          labelStyle: TextStyle(
                            color: actif ? Colors.white : Colors.black,
                          ),
                          onSelected: (_) {
                            setState(() => filtreSelectionne = index);
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Liste
                ...reparationsFiltrees.map((r) => _CarteReparation(data: r)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CarteReparation extends StatelessWidget {
  final Map<String, String> data;

  const _CarteReparation({required this.data});

  Color get _couleurStatut {
    switch (data["statut"]) {
      case "En cours":
        return Colors.orange;
      case "Terminée":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CouleursApp.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.build_circle, color: CouleursApp.orange, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  data["vehicule"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: CouleursApp.bleuFonce,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _couleurStatut.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data["statut"]!,
                  style: TextStyle(
                    color: _couleurStatut,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            data["description"]!,
            style: const TextStyle(fontSize: 14),
          ),

          const SizedBox(height: 12),

          const Divider(height: 1, color: CouleursApp.bordure),

          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: CouleursApp.grisTexte),
              const SizedBox(width: 4),
              Text(data["date"]!, style: const TextStyle(color: CouleursApp.grisTexte, fontSize: 13)),
              const Spacer(),
              const Icon(Icons.storefront, size: 14, color: CouleursApp.grisTexte),
              const SizedBox(width: 4),
              Text(data["mecanicien"]!, style: const TextStyle(color: CouleursApp.grisTexte, fontSize: 13)),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Montant",
                style: TextStyle(color: CouleursApp.grisTexte, fontSize: 13),
              ),
              Text(
                data["montant"]!,
                style: const TextStyle(
                  color: CouleursApp.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
