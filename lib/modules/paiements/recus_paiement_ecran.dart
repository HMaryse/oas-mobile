import 'package:flutter/material.dart';
import '../../core/theme/couleurs_app.dart';

class RecusPaiementEcran extends StatefulWidget {
  const RecusPaiementEcran({super.key});

  @override
  State<RecusPaiementEcran> createState() => _RecusPaiementEcranState();
}

class _RecusPaiementEcranState extends State<RecusPaiementEcran> {
  int filtreSelectionne = 0;

  final List<String> filtres = ["Tous", "Wave", "Orange Money", "Espèces"];

  final List<Map<String, String>> recus = [
    {
      "numero": "REC-2026-001",
      "facture": "FAC-2026-001",
      "vehicule": "Toyota Hilux - DK-8849-B",
      "description": "Changement plaquettes de frein",
      "date": "13 Juin 2026",
      "montant": "45 000 FCFA",
      "methode": "Wave",
      "reference": "WV-48291034",
    },
    {
      "numero": "REC-2026-002",
      "facture": "FAC-2026-003",
      "vehicule": "Toyota Hilux - DK-8849-B",
      "description": "Révision complète 30 000 km",
      "date": "03 Mai 2026",
      "montant": "120 000 FCFA",
      "methode": "Orange Money",
      "reference": "OM-73810291",
    },
    {
      "numero": "REC-2026-003",
      "facture": "FAC-2025-018",
      "vehicule": "Renault Clio IV - DK-2208-CD",
      "description": "Vidange + filtre à huile",
      "date": "10 Nov 2025",
      "montant": "28 000 FCFA",
      "methode": "Espèces",
      "reference": "ESP-00018",
    },
  ];

  List<Map<String, String>> get recusFiltres {
    if (filtreSelectionne == 0) return recus;
    final filtre = filtres[filtreSelectionne];
    return recus.where((r) => r["methode"] == filtre).toList();
  }

  String get _totalPaye {
    final total = recus.fold<int>(0, (sum, r) {
      final v = int.tryParse(r["montant"]!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
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
          "Mes Reçus de Paiement",
          style: TextStyle(color: CouleursApp.bleuFonce, fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
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
                  child: const Icon(Icons.payments, color: CouleursApp.orange),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${recus.length} reçus",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Total payé : $_totalPaye",
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
                    labelStyle: TextStyle(color: actif ? Colors.white : Colors.black),
                    onSelected: (_) => setState(() => filtreSelectionne = index),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          ...recusFiltres.map((r) => _CarteRecu(data: r)),
        ],
      ),
    );
  }
}

class _CarteRecu extends StatelessWidget {
  final Map<String, String> data;
  const _CarteRecu({required this.data});

  IconData get _iconeMethode {
    switch (data["methode"]) {
      case "Wave":
        return Icons.waves;
      case "Orange Money":
        return Icons.phone_android;
      default:
        return Icons.money;
    }
  }

  Color get _couleurMethode {
    switch (data["methode"]) {
      case "Wave":
        return Colors.blue;
      case "Orange Money":
        return Colors.orange;
      default:
        return Colors.green;
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
                  color: _couleurMethode.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(_iconeMethode, color: _couleurMethode, size: 20),
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
                      "Facture : ${data["facture"]!}",
                      style: const TextStyle(color: CouleursApp.grisTexte, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _couleurMethode.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data["methode"]!,
                  style: TextStyle(
                    color: _couleurMethode,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(data["description"]!, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            data["vehicule"]!,
            style: const TextStyle(color: CouleursApp.grisTexte, fontSize: 13),
          ),

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

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(Icons.tag, size: 14, color: CouleursApp.grisTexte),
              const SizedBox(width: 4),
              Text(
                "Réf : ${data["reference"]!}",
                style: const TextStyle(color: CouleursApp.grisTexte, fontSize: 13),
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
                "Télécharger le reçu",
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
