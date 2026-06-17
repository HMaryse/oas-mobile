class VehiculeModel {
  final int id;
  final String immatriculation;
  final int annee;
  final String modele;
  final String marque;
  final double kilometrage;
  final String numeroChassis;

  VehiculeModel({
    required this.id,
    required this.immatriculation,
    required this.annee,
    required this.modele,
    required this.marque,
    required this.kilometrage,
    required this.numeroChassis,
  });

  factory VehiculeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return VehiculeModel(
      id: json['id'],
      immatriculation:
          json['immatriculation'] ?? '',
      annee: json['annee'] ?? 0,
      modele: json['modele'] ?? '',
      marque: json['marque'] ?? '',
      kilometrage:
          (json['kilometrage'] ?? 0)
              .toDouble(),
      numeroChassis:
          json['numeroChassis'] ?? '',
    );
  }
}