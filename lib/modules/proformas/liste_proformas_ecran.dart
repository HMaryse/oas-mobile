import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'detail_proforma_ecran.dart';
import 'models/proforma.dart';
import 'repository/proforma_repository.dart';

class ListeProformasEcran extends StatefulWidget {
  const ListeProformasEcran({super.key});

  @override
  State<ListeProformasEcran> createState() =>
      _ListeProformasEcranState();
}

class _ListeProformasEcranState
    extends State<ListeProformasEcran> {
  final ProformaRepository repository =
      ProformaRepository();

  List<Proforma> proformas = [];

  bool chargement = true;

  int filtreSelectionne = 0;

  final List<String> filtres = [
    "Tous",
    "En attente",
    "Acceptés",
    "Rejetés",
  ];

  @override
  void initState() {
    super.initState();
    chargerProformas();
  }

  Future<void> chargerProformas() async {
    try {
      final resultat =
          await repository.getProformas();

      setState(() {
        proformas = resultat;
        chargement = false;
      });
    } catch (e) {
      setState(() {
        chargement = false;
      });

      debugPrint(
        'Erreur proformas : $e',
      );
    }
  }

  Future<void> validerProforma(
    int id,
  ) async {
    try {
      await repository
          .validerProforma(id);

      await chargerProformas();

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Proforma validé",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text("$e"),
        ),
      );
    }
  }

  Future<void> refuserProforma(
    int id,
  ) async {
    try {
      await repository
          .refuserProforma(id);

      await chargerProformas();

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Proforma refusé",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text("$e"),
        ),
      );
    }
  }

  Color couleurStatut(
    String statut,
  ) {
    switch (statut) {
      case 'ACCEPTE':
        return Colors.green;

      case 'REJETTE':
      case 'ANNULEE':
        return Colors.red;

      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chargement) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    List<Proforma> proformasFiltrees =
        proformas.where((p) {
      switch (filtreSelectionne) {
        case 1:
          return p.statut ==
              "EN_ATTENTE";

        case 2:
          return p.statut ==
              "ACCEPTE";

        case 3:
          return p.statut ==
                  "REJETTE" ||
              p.statut ==
                  "ANNULEE";

        default:
          return true;
      }
    }).toList();

    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor:
            CouleursApp.grisFond,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mes Proformas',
          style: TextStyle(
            color:
                CouleursApp.bleuFonce,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh:
            chargerProformas,

        child: proformas.isEmpty
            ? ListView(
                children: const [
                  SizedBox(
                    height: 200,
                  ),
                  Icon(
                    Icons.description_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Aucun proforma disponible',
                    ),
                  ),
                ],
              )
            : ListView(
                padding:
                    const EdgeInsets.all(
                        16),
                children: [
                  SizedBox(
                    height: 42,
                    child: ListView.builder(
                      scrollDirection:
                          Axis.horizontal,
                      itemCount:
                          filtres.length,
                      itemBuilder:
                          (context, index) {
                        final actif =
                            filtreSelectionne ==
                                index;

                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            right: 8,
                          ),
                          child: ChoiceChip(
                            label: Text(
                              filtres[index],
                            ),
                            selected:
                                actif,
                            selectedColor:
                                CouleursApp
                                    .bleuFonce,
                            labelStyle:
                                TextStyle(
                              color: actif
                                  ? Colors
                                      .white
                                  : Colors
                                      .black,
                            ),
                            onSelected:
                                (_) {
                              setState(() {
                                filtreSelectionne =
                                    index;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  ...proformasFiltrees.map(
                    (proforma) {
                      return Container(
                        margin:
                            const EdgeInsets.only(
                          bottom: 16,
                        ),
                        padding:
                            const EdgeInsets.all(
                          16,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,
                          borderRadius:
                              BorderRadius.circular(
                                  16),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    proforma.numero,
                                    style:
                                        const TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                      fontSize:
                                          16,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal:
                                        12,
                                    vertical:
                                        6,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        couleurStatut(
                                      proforma
                                          .statut,
                                    ).withOpacity(
                                            0.15),
                                    borderRadius:
                                        BorderRadius.circular(
                                            20),
                                  ),
                                  child: Text(
                                    proforma
                                        .statut,
                                    style:
                                        TextStyle(
                                      color:
                                          couleurStatut(
                                        proforma
                                            .statut,
                                      ),
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            Text(
                              '${proforma.marque} ${proforma.modele}',
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            Text(
                              proforma
                                  .immatriculation,
                              style:
                                  const TextStyle(
                                color:
                                    Colors.grey,
                              ),
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            Text(
                              '${proforma.montantTotal.toStringAsFixed(0)} FCFA',
                              style:
                                  const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight
                                        .bold,
                                color:
                                    CouleursApp
                                        .orange,
                              ),
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child:
                                      OutlinedButton(
                                    onPressed:
                                        () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) =>
                                                  DetailProformaEcran(
                                            proforma:
                                                proforma,
                                          ),
                                        ),
                                      );
                                    },
                                    child:
                                        const Text(
                                      "Détails",
                                    ),
                                  ),
                                ),

                                if (proforma
                                        .statut ==
                                    "EN_ATTENTE") ...[
                                  const SizedBox(
                                    width: 8,
                                  ),

                                  Expanded(
                                    child:
                                        ElevatedButton(
                                      onPressed:
                                          () =>
                                              validerProforma(
                                        proforma
                                            .id,
                                      ),
                                      style:
                                          ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.green,
                                        foregroundColor:
                                            Colors.white,
                                      ),
                                      child:
                                          const Text(
                                        "Valider",
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 8,
                                  ),

                                  Expanded(
                                    child:
                                        ElevatedButton(
                                      onPressed:
                                          () =>
                                              refuserProforma(
                                        proforma
                                            .id,
                                      ),
                                      style:
                                          ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.red,
                                        foregroundColor:
                                            Colors.white,
                                      ),
                                      child:
                                          const Text(
                                        "Refuser",
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}