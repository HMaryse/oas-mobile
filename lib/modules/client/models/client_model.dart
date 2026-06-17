class ClientModel {
  final int id;
  final String matricule;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String username;
  final String type;

  ClientModel({
    required this.id,
    required this.matricule,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.type,
  });

  factory ClientModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ClientModel(
      id: json['id'],
      matricule: json['matricule'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      username: json['username'] ?? '',
      type: json['type'] ?? '',
    );
  }
}