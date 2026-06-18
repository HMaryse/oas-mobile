import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import 'models/proforma.dart';
import 'repository/proforma_repository.dart';

class DetailProformaEcran extends StatefulWidget {
  final Proforma proforma;

  const DetailProformaEcran({
    super.key,
    required this.proforma,
  });

  @override
  State<DetailProformaEcran> createState() =>
      _DetailProformaEcranState();
}

class _DetailProformaEcranState
    extends State<DetailProformaEcran> {

  final ProformaRepository repository =
      ProformaRepository();

  bool traitement = false;

  Future<void> validerProforma() async {
    try {

      setState(() {
        traitement = true;
      });

      await repository.validerProforma(
        widget.proforma.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Proforma validé avec succès',
          ),
        ),
      );

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Erreur : $e',
          ),
        ),
      );

    } finally {

      if (mounted) {
        setState(() {
          traitement = false;
        });
      }
    }
  }

  Future<void> refuserProforma() async {
    try {

      setState(() {
        traitement = true;
      });

      await repository.refuserProforma(
        widget.proforma.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Proforma refusé',
          ),
        ),
      );

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Erreur : $e',
          ),
        ),
      );

    } finally {

      if (mounted) {
        setState(() {
          traitement = false;
        });
      }
    }
  }

  Widget ligneMontant(
    String titre,
    String valeur,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 6,
      ),

      child: Row(
        children: [

          Expanded(
            child: Text(
              titre,
            ),
          ),

          Text(
            valeur,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final proforma =
        widget.proforma;

    return Scaffold(
      backgroundColor:
          CouleursApp.grisFond,

      appBar: AppBar(
        backgroundColor:
            CouleursApp.grisFond,

        elevation: 0,

        centerTitle: true,

        title: const Text(
          'Détail Proforma',
          style: TextStyle(
            color:
                CouleursApp.bleuFonce,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        18),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(
                    proforma.numero,

                    style:
                        const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    proforma.dateCreation,
                    style:
                        const TextStyle(
                      color:
                          Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        18),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Text(
                    'Véhicule',

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
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
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    '${proforma.kilometrage.toInt()} km',
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        18),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Text(
                    'Pièces',

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  ...proforma
                      .lignesPieces
                      .map(
                    (piece) {

                      return ListTile(
                        contentPadding:
                            EdgeInsets.zero,

                        title: Text(
                          piece
                              .designationPiece,
                        ),

                        subtitle: Text(
                          'Qté : ${piece.quantite}',
                        ),

                        trailing: Text(
                          '${piece.montantTotal.toStringAsFixed(0)} FCFA',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        18),
              ),

              child: Column(
                children: [

                  ligneMontant(
                    'Montant HT',
                    '${proforma.montantHT.toStringAsFixed(0)} FCFA',
                  ),

                  ligneMontant(
                    'TVA',
                    '${proforma.montantTVA.toStringAsFixed(0)} FCFA',
                  ),

                  ligneMontant(
                    'Timbre',
                    '${proforma.montantTimbre.toStringAsFixed(0)} FCFA',
                  ),

                  const Divider(),

                  ligneMontant(
                    'TOTAL',
                    '${proforma.montantTotal.toStringAsFixed(0)} FCFA',
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            if (proforma.statut ==
                'EN_ATTENTE')
              Row(
                children: [

                  Expanded(
                    child:
                        ElevatedButton(
                      onPressed:
                          traitement
                              ? null
                              : validerProforma,

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green,
                        foregroundColor:
                            Colors.white,
                      ),

                      child: const Text(
                        'Valider',
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child:
                        ElevatedButton(
                      onPressed:
                          traitement
                              ? null
                              : refuserProforma,

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red,
                        foregroundColor:
                            Colors.white,
                      ),

                      child: const Text(
                        'Refuser',
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}