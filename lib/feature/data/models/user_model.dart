import 'package:iteach/feature/domain/entities/user_entity.dart';

Map<String, dynamic> createUserFromEntity(UserEntity data) {
  var model = UserModel.convertEntityToModel(data);
  return model.toJson();
}

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.username,
    required super.password,
    required super.email,
    required super.address,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      address: json['address'],
    );
  }
  static UserModel convertEntityToModel(UserEntity entity) {
    return UserModel(
      name: entity.name,
      username: entity.username,
      password: entity.password,
      email: entity.email,
      address: entity.address,
    );
  }
}
