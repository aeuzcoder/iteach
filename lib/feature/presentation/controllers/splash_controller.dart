import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:iteach/feature/data/datasources/database/db_service.dart';
import 'package:iteach/feature/presentation/pages/login_page/login_page.dart';
import 'package:iteach/feature/presentation/pages/main_page.dart';
import 'package:iteach/feature/presentation/pages/offline_page.dart';

import 'base_controller.dart';

class SplashController extends BaseController {
  initTimer() {
    Timer(const Duration(milliseconds: 1500), () {
      _callNextPage();
    });
  }

  _callNextPage() async {
    if (await userRepo.internetInfo()) {
      Get.off(() => const OfflinePage());
    } else {
      if (DBService.to.getAccessToken().isNotEmpty) {
        final res = await refreshToken(DBService.to.getAccessToken());
        if (res == null) {
          Get.off(() => const LoginPage());
        } else {
          log('NEW TOKEN: $res');
          Get.off(() => const MainPage());
        }
      } else {
        Get.off(() => const LoginPage());
      }
    }
  }

  Future<String?> refreshToken(String currentToken) async {
    var result = await userRepo.refreshToken(currentToken);
    return result.fold((error) {
      log('ERROR ON REFRESH TOKEN: $error');

      return null;
    }, (token) async {
      await DBService.to.delAccessToken();
      await DBService.to.setAccessToken(token);
      return token;
    });
  }
}
