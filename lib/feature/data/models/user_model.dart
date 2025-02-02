class UserModel {
  String? email;
  String? role;
  String? image;
  String? fullName;
  int? id;
  String? password;
  String? token;
  String? phoneNumber;

  UserModel({
    this.email,
    this.role,
    this.image,
    this.fullName,
    this.id,
    this.password,
    this.token,
    this.phoneNumber,
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
      phoneNumber: json['phone_number'].toString(),
    );
  }

  Map<String, String> toJson() {
    return {
      if (email != null) 'email': email!,
      if (role != null) 'role': role!,
      if (image != null) 'image': image!,
      if (fullName != null) 'full_name': fullName!,
      if (id != null) 'id': id!.toString(),
      if (password != null) 'password': password!,
      if (token != null) 'token': token!,
      if (phoneNumber != null) 'phone_number': phoneNumber!,
    };
  }
}
