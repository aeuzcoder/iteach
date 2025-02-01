import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:iteach/core/errors/exception.dart';
import 'package:iteach/core/network/api_constants.dart';
import 'package:iteach/core/services/network_info.dart';
import 'package:iteach/feature/data/datasources/network/network_service.dart';
import 'package:iteach/feature/data/models/sign_in_model.dart';
import 'package:iteach/feature/data/models/user_model.dart';
import 'package:iteach/feature/domain/entities/sign_in_entity.dart';
import 'package:iteach/feature/domain/entities/user_entity.dart';
import 'package:iteach/feature/domain/repository/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final NetworkInfo networkInfo;
  UserRepoImpl({required this.networkInfo});
  @override
  Future<Either<String, SignInEntity>> signIn(
      {required String username, required String password}) async {
    try {
      final response = await NetworkService.POST(
        ApiConstants.TOKEN,
        {
          'username': username,
          'password': password,
        },
        isAuth: true,
      );
      final resultJson = jsonDecode(response!);

      final result = SignInModel.fromJson(resultJson);

      return Right(result);
    } on InvalidInputException {
      return Left('Login yoki parolda xatolik');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> signUp({required UserEntity user}) async {
    try {
      var response = await NetworkService.POST(
          ApiConstants.USERS_CREATE_USERS, createUserFromEntity(user));
      var result = jsonDecode(response ?? '');
      return Right(result['message']);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> internetInfo() async {
    final bool result = await networkInfo.isConnected;
    log('INTERNET: $result');
    if (result) {
      return false;
    } else {
      return true;
    }
  }
}
