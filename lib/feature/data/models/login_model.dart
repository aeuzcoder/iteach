class LoginModel {
  final int id;
  final String accessToken;
  final String tokenType;
  final String role;

  LoginModel({
    required this.id,
    required this.accessToken,
    required this.tokenType,
    required this.role,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'access_token': accessToken,
      'token_type': tokenType,
      'role': role,
    };
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      role: json['role'],
    );
  }
}
