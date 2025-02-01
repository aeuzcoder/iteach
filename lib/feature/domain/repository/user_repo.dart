import 'package:dartz/dartz.dart';
import 'package:iteach/feature/data/models/login_model.dart';

abstract class UserRepo {
  //LOGIN
  Future<Either<String, LoginModel>> login(
      {required String username, required String password});

  //REFRESH TOKEN
  Future<Either<String, String>> refreshToken(String currentToken);

  //CHECK INTERNET
  Future<bool> internetInfo();
}
