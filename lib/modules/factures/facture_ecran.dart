import 'package:flutter/material.dart';
import '../../core/theme/couleurs_app.dart';

class FacturesEcran extends StatefulWidget {
  const FacturesEcran({super.key});

  @override
  State<FacturesEcran> createState() => _FacturesEcranState();
}

class _FacturesEcranState extends State<FacturesEcran> {
  int filtreSelectionne = 0;

  final List<String> filtres = [
    "Toutes",
    "Payées",
    "En attente",
  ];

  final List<Map<String, String>> factures = [
    {
      "numero": "FAC-2026-001",
      "vehicule": "Toyota Hilux - DK-8849-B",
      "description": "Changement plaquettes de frein",
      "date": "13 Juin 2026",
      "montant": "45 000 FCFA",
      "statut": "Payée",
    },
    {
      "numero": "FAC-2026-002",
      "vehicule": "Renault Clio IV - DK-2208-CD",
      "description": "Diagnostic + réparation courroie",
      "date": "21 Juin 2026",
      "montant": "85 000 FCFA",
      "statut": "En attente",
    },
    {
      "numero": "FAC-2026-003",
      "vehicule": "Toyota Hilux - DK-8849-B",
      "description": "Révision complète 30 000 km",
      "date": "03 Mai 2026",
      "montant": "120 000 FCFA",
      "statut": "Payée",
    },
  ];

  List<Map<String, String>> get facturesFiltrees {
    if (filtreSelectionne == 0) return factures;
    final filtre = filtres[filtreSelectionne];
    return factures.where((f) => f["statut"] == filtre).toList();
  }

  String get _totalMontant {
    final total = factures.fold<int>(0, (sum, f) {
      final v = int.tryParse(f["montant"]!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + v;
    });
    return "${_formatNombre(total)} FCFA";
  }

  String _formatNombre(int n) {
    return n.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]} ',
    );
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
          "Mes Factures",
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
                        child: const Icon(Icons.receipt_long, color: CouleursApp.orange),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${factures.length} factures",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Total : $_totalMontant",
                              style: const TextStyle(color: Colors.grey),
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
                ...facturesFiltrees.map((f) => _CarteFacture(data: f)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CarteFacture extends StatelessWidget {
  final Map<String, String> data;

  const _CarteFacture({required this.data});

  Color get _couleurStatut {
    switch (data["statut"]) {
      case "Payée":
        return Colors.green;
      case "En attente":
        return Colors.orange;
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
                child: const Icon(Icons.receipt, color: CouleursApp.orange, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["numero"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: CouleursApp.bleuFonce,
                      ),
                    ),
                    Text(
                      data["vehicule"]!,
                      style: const TextStyle(color: CouleursApp.grisTexte, fontSize: 12),
                    ),
                  ],
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

          Text(data["description"]!, style: const TextStyle(fontSize: 14)),

          const SizedBox(height: 12),
          const Divider(height: 1, color: CouleursApp.bordure),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: CouleursApp.grisTexte),
                  const SizedBox(width: 4),
                  Text(data["date"]!, style: const TextStyle(color: CouleursApp.grisTexte, fontSize: 13)),
                ],
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

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, size: 16, color: CouleursApp.bleuFonce),
              label: const Text(
                "Télécharger la facture",
                style: TextStyle(color: CouleursApp.bleuFonce, fontSize: 13),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: CouleursApp.bordure),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
