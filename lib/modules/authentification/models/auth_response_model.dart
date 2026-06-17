class AuthResponseModel {
  final String token;
  final String tokenType;
  final String username;
  final String role;

  AuthResponseModel({
    required this.token,
    required this.tokenType,
    required this.username,
    required this.role,
  });

  factory AuthResponseModel.fromJson(
      Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'],
      tokenType: json['tokenType'],
      username: json['username'],
      role: json['role'],
    );
  }
}