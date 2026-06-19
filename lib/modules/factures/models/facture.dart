class Facture {
  final int id;
  final String numero;
  final String statut;

  final DateTime dateCreation;

  final double montantTotal;
  final double montantHT;
  final double montantTVA;
  final double montantTTC;
  final double montantTimbre;

  final double montantPaye;

  final double kilometrage;

  final String? remarque;

  Facture({
    required this.id,
    required this.numero,
    required this.statut,
    required this.dateCreation,
    required this.montantTotal,
    required this.montantHT,
    required this.montantTVA,
    required this.montantTTC,
    required this.montantTimbre,
    required this.montantPaye,
    required this.kilometrage,
    this.remarque,
  });

  double get resteAPayer =>
      montantTotal - montantPaye;

  factory Facture.fromJson(
    Map<String, dynamic> json,
  ) {
    return Facture(
      id: json['id'],

      numero: json['numero'] ?? '',

      statut: json['statut'] ?? '',

      dateCreation: DateTime.parse(
        json['dateCreation'],
      ),

      montantTotal:
          (json['montantTotal'] ?? 0)
              .toDouble(),

      montantHT:
          (json['montantHT'] ?? 0)
              .toDouble(),

      montantTVA:
          (json['montantTVA'] ?? 0)
              .toDouble(),

      montantTTC:
          (json['montantTTC'] ?? 0)
              .toDouble(),

      montantTimbre:
          (json['montantTimbre'] ?? 0)
              .toDouble(),

      montantPaye:
          (json['montantPaye'] ?? 0)
              .toDouble(),

      kilometrage:
          (json['kilometrage'] ?? 0)
              .toDouble(),

      remarque: json['remarque'],
    );
  }
}