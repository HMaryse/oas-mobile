class RendezVous {
  final int? id;
  final DateTime dateRendezVous;
  final String motif;
  final String statut;
  final String? commentaire;
  final int? vehiculeId;

  RendezVous({
    this.id,
    required this.dateRendezVous,
    required this.motif,
    required this.statut,
    this.commentaire,
    this.vehiculeId,
  });
}