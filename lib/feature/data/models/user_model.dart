class UserModel {
  final String email;
  final String role;
  final String image;
  final String fullName;
  final int id;
  final String password;
  final String token;
  final int phoneNumber;

  UserModel({
    required this.email,
    required this.role,
    required this.image,
    required this.fullName,
    required this.id,
    required this.password,
    required this.token,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      role: json['role'],
      image: json['image'],
      fullName: json['full_name'],
      id: json['id'],
      password: json['password'],
      token: json['token'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
      'image': image,
      'full_name': fullName,
      'id': id,
      'password': password,
      'token': token,
      'phone_number': phoneNumber,
    };
  }
}
