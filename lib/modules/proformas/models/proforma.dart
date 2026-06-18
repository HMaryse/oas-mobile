class LignePieceProforma {
  final int id;
  final int pieceId;
  final String designationPiece;
  final int quantite;
  final double prix;
  final double montantTotal;

  LignePieceProforma({
    required this.id,
    required this.pieceId,
    required this.designationPiece,
    required this.quantite,
    required this.prix,
    required this.montantTotal,
  });

  factory LignePieceProforma.fromJson(
    Map<String, dynamic> json,
  ) {
    return LignePieceProforma(
      id: json['id'] ?? 0,
      pieceId: json['pieceId'] ?? 0,
      designationPiece:
          json['designationPiece'] ?? '',
      quantite: json['quantite'] ?? 0,
      prix:
          (json['prix'] ?? 0)
              .toDouble(),
      montantTotal:
          (json['montantTotal'] ?? 0)
              .toDouble(),
    );
  }
}

class Proforma {
  final int id;

  final String numero;

  final String clientNom;

  final int clientId;

  final int vehiculeId;

  final String immatriculation;

  final String marque;

  final String modele;

  final int annee;

  final double kilometrage;

  final String numeroChassis;

  final String statut;

  final String? remarque;

  final String dateCreation;

  final double montantHT;

  final double montantTVA;

  final double montantTimbre;

  final double montantAutre;

  final double montantTTC;

  final double montantTotal;

  final List<LignePieceProforma>
      lignesPieces;

  Proforma({
    required this.id,
    required this.numero,
    required this.clientNom,
    required this.clientId,
    required this.vehiculeId,
    required this.immatriculation,
    required this.marque,
    required this.modele,
    required this.annee,
    required this.kilometrage,
    required this.numeroChassis,
    required this.statut,
    required this.dateCreation,
    required this.montantHT,
    required this.montantTVA,
    required this.montantTimbre,
    required this.montantAutre,
    required this.montantTTC,
    required this.montantTotal,
    required this.lignesPieces,
    this.remarque,
  });

  factory Proforma.fromJson(
    Map<String, dynamic> json,
  ) {
    return Proforma(
      id: json['id'] ?? 0,

      numero:
          json['numero'] ?? '',

      clientNom:
          json['clientNom'] ?? '',

      clientId:
          json['clientId'] ?? 0,

      vehiculeId:
          json['vehiculeId'] ?? 0,

      immatriculation:
          json['immatriculation'] ?? '',

      marque:
          json['marque'] ?? '',

      modele:
          json['modele'] ?? '',

      annee:
          json['annee'] ?? 0,

      kilometrage:
          (json['kilometrage'] ?? 0)
              .toDouble(),

      numeroChassis:
          json['numeroChassis'] ?? '',

      statut:
          json['statut'] ?? '',

      remarque:
          json['remarque'],

      dateCreation:
          json['dateCreation'] ?? '',

      montantHT:
          (json['montantHT'] ?? 0)
              .toDouble(),

      montantTVA:
          (json['montantTVA'] ?? 0)
              .toDouble(),

      montantTimbre:
          (json['montantTimbre'] ?? 0)
              .toDouble(),

      montantAutre:
          (json['montantAutre'] ?? 0)
              .toDouble(),

      montantTTC:
          (json['montantTTC'] ?? 0)
              .toDouble(),

      montantTotal:
          (json['montantTotal'] ?? 0)
              .toDouble(),

      lignesPieces:
          (json['lignesPieces']
                      as List? ??
                  [])
              .map(
                (e) =>
                    LignePieceProforma
                        .fromJson(e),
              )
              .toList(),
    );
  }
}