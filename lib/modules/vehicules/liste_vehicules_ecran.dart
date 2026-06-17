import 'package:flutter/material.dart';

import '../../core/theme/couleurs_app.dart';
import '../../core/widgets/carte_vehicule.dart';
import '../vehicules/models/vehicule_model.dart';
import '../vehicules/repository/vehicule_repository.dart';

import 'ajouter_vehicule_ecran.dart';
import 'detail_vehicule_ecran.dart';


class ListeVehiculesEcran extends StatefulWidget {
  const ListeVehiculesEcran({super.key});

  @override
  State<ListeVehiculesEcran> createState() =>
      _ListeVehiculesEcranState();
}

class _ListeVehiculesEcranState
    extends State<ListeVehiculesEcran> {

  final VehiculeRepository repository =
      VehiculeRepository();

  List<VehiculeModel> vehicules = [];

  bool chargement = true;

  @override
  void initState() {
    super.initState();
    chargerVehicules();
  }

  Future<void> chargerVehicules() async {
    try {
      final resultat =
          await repository.getVehicules();

      setState(() {
        vehicules = resultat;
        chargement = false;
      });
    } catch (e) {
      setState(() {
        chargement = false;
      });

      debugPrint(
        "Erreur véhicules : $e",
      );
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
          "Mes Véhicules",
          style: TextStyle(
            color:
                CouleursApp.bleuFonce,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color:
                  CouleursApp.orange,
            ),
            onPressed: () async {
              final resultat =
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const AjouterVehiculeEcran(),
                  ),
                );

              if (resultat == true) {
              chargerVehicules();
              }
            },
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh:
            chargerVehicules,

        child: vehicules.isEmpty
            ? ListView(
                children: const [

                  SizedBox(
                    height: 200,
                  ),

                  Icon(
                    Icons
                        .directions_car_outlined,
                    size: 80,
                    color:
                        Colors.grey,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Center(
                    child: Text(
                      "Aucun véhicule enregistré",
                      style:
                          TextStyle(
                        fontSize:
                            16,
                        color: Colors
                            .grey,
                      ),
                    ),
                  ),
                ],
              )
            : ListView(
                padding:
                    const EdgeInsets
                        .all(16),

                children: [

                  Container(
                    margin:
                        const EdgeInsets
                            .only(
                      bottom: 20,
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

                    child: Row(
                      children: [

                        const Icon(
                          Icons
                              .directions_car,
                          color:
                              CouleursApp
                                  .orange,
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        Text(
                          "${vehicules.length} véhicule(s) enregistré(s)",

                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ...vehicules.map(
                    (vehicule) {

                      return CarteVehicule(
                        marqueModele:
                            "${vehicule.marque} ${vehicule.modele}",

                        immatriculation:
                            vehicule
                                .immatriculation,

                        annee: vehicule
                            .annee
                            .toString(),

                        kilometrage:
                            "${vehicule.kilometrage.toInt()} km",

                        onDetails: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailVehiculeEcran(
                                    vehicule: vehicule,
                                  ),
                            ),
                          );
                        },

                      );
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,

                    child:
                        OutlinedButton.icon(
                      onPressed:
                          () async {
                        final resultat =
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const AjouterVehiculeEcran(),
                            ),
                          );

                        if (resultat == true) {
                          chargerVehicules();
                        }
                      },

                      icon:
                          const Icon(
                        Icons.add,
                        color:
                            CouleursApp.orange,
                      ),

                      label:
                          const Text(
                        "Ajouter un véhicule",

                        style:
                            TextStyle(
                          color:
                              CouleursApp
                                  .bleuFonce,

                          fontWeight:
                              FontWeight
                                  .w600,
                        ),
                      ),

                      style:
                          OutlinedButton.styleFrom(
                        side:
                            BorderSide(
                          color: Colors
                              .grey
                              .shade300,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}