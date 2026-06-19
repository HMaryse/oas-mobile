class Reparation {
  final int id;
  final String numero;
  final String descriptionTravaux;
  final String statut;
  final DateTime dateCreation;
  final DateTime? dateSortie;
  final String? listeReception;
  final String? listeDefauts;

  Reparation({
    required this.id,
    required this.numero,
    required this.descriptionTravaux,
    required this.statut,
    required this.dateCreation,
    this.dateSortie,
    this.listeReception,
    this.listeDefauts,
  });

  factory Reparation.fromJson(
    Map<String, dynamic> json,
  ) {
    return Reparation(
      id: json['id'],
      numero: json['numero'] ?? '',
      descriptionTravaux:
          json['descriptionTravaux'] ?? '',
      statut: json['statut'] ?? '',
      dateCreation: DateTime.parse(
        json['dateCreation'],
      ),
      dateSortie: json['dateSortie'] != null
          ? DateTime.parse(
              json['dateSortie'],
            )
          : null,
      listeReception:
          json['listeReception'],
      listeDefauts:
          json['listeDefauts'],
    );
  }
}