import 'package:dartz/dartz.dart';
import 'package:iteach/feature/domain/entities/sign_in_entity.dart';
import 'package:iteach/feature/domain/entities/user_entity.dart';

abstract class UserRepo {
  //SIGN IN
  Future<Either<String, SignInEntity>> signIn(
      {required String username, required String password});

  //SIGN UP
  Future<Either<String, String>> signUp({required UserEntity user});

  //CHECK INTERNET
  Future<bool> internetInfo();
}
