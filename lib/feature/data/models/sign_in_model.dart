import 'package:iteach/feature/domain/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity {
  SignInModel({
    required super.accessToken,
    required super.tokenType,
    required super.role,
  });
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'role': role,
    };
  }

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      role: json['role'],
    );
  }
}
