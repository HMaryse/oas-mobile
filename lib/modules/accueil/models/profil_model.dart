class ProfilModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String matricule;
  final String username;
  final String createdAt;

  ProfilModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.matricule,
    required this.username,
    required this.createdAt,
  });

  factory ProfilModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProfilModel(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      matricule: json['matricule'] ?? '',
      username: json['username'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}