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

  Color couleurStatut(
    String statut,
  ) {
    switch (statut) {

      case 'VALIDE':
        return Colors.green;

      case 'REFUSE':
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

            : ListView.builder(
                padding:
                    const EdgeInsets.all(
                        16),

                itemCount:
                    proformas.length,

                itemBuilder:
                    (context, index) {

                  final proforma =
                      proformas[index];

                  return Container(
                    margin:
                        const EdgeInsets
                            .only(
                      bottom: 16,
                    ),

                    padding:
                        const EdgeInsets
                            .all(16),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white,

                      borderRadius:
                          BorderRadius
                              .circular(
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
                                  const EdgeInsets
                                      .symmetric(
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

                        SizedBox(
                          width:
                              double.infinity,

                          child:
                              ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  CouleursApp
                                      .orange,

                              foregroundColor:
                                  Colors
                                      .white,
                            ),

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
                              'Voir détails',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}