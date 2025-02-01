import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:iteach/core/errors/exception.dart';
import 'package:iteach/core/network/api_constants.dart';
import 'package:iteach/core/services/network_info.dart';
import 'package:iteach/feature/data/datasources/network/network_service.dart';
import 'package:iteach/feature/data/models/login_model.dart';
import 'package:iteach/feature/domain/repository/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final NetworkInfo networkInfo;
  UserRepoImpl({required this.networkInfo});
  @override
  Future<Either<String, LoginModel>> login(
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

      final result = LoginModel.fromJson(resultJson);

      return Right(result);
    } on InvalidInputException {
      return Left('Login yoki parolda xatolik');
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

  @override
  Future<Either<String, String>> refreshToken(String currentToken) async {
    try {
      final response = await NetworkService.POST(
          ApiConstants.REFRESH_TOKEN, NetworkService.paramsEmpty());
      final resultJson = jsonDecode(response!);
      String result = resultJson['access_token'];
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
