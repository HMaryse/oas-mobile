class NotificationModel {
  final int id;
  final String titre;
  final String message;
  final bool lu;
  final String dateCreation;

  NotificationModel({
    required this.id,
    required this.titre,
    required this.message,
    required this.lu,
    required this.dateCreation,
  });

  factory NotificationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return NotificationModel(
      id: json['id'],
      titre: json['titre'] ?? '',
      message: json['message'] ?? '',
      lu: json['lu'] ?? false,
      dateCreation:
          json['dateCreation'] ?? '',
    );
  }
}