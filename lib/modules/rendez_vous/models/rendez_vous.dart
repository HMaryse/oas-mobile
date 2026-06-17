class RendezVous {
  final int id;
  final int clientId;
  final String clientName;
  final int vehiculeId;
  final String vehiculeImmatriculation;
  final DateTime dateRendezVous;
  final String motif;
  final String statut;
  final String? commentaire;

  RendezVous({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.vehiculeId,
    required this.vehiculeImmatriculation,
    required this.dateRendezVous,
    required this.motif,
    required this.statut,
    this.commentaire,
  });

  factory RendezVous.fromJson(
    Map<String, dynamic> json,
  ) {
    return RendezVous(
      id: json['id'],
      clientId: json['clientId'],
      clientName: json['clientName'] ?? '',
      vehiculeId: json['vehiculeId'],
      vehiculeImmatriculation:
          json['vehiculeImmatriculation'] ?? '',
      dateRendezVous: DateTime.parse(
        json['dateRendezVous'],
      ),
      motif: json['motif'] ?? '',
      statut: json['statut'] ?? '',
      commentaire: json['commentaire'],
    );
  }
}