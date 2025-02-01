import 'dart:async';

import 'package:get/get.dart';
import 'package:iteach/feature/data/datasources/database/db_service.dart';
import 'package:iteach/feature/presentation/pages/home_page/home_page.dart';
import 'package:iteach/feature/presentation/pages/login_page/login_page.dart';
import 'package:iteach/feature/presentation/pages/offline_page.dart';

import 'base_controller.dart';

class SplashController extends BaseController {
  initTimer() {
    Timer(const Duration(seconds: 0), () {
      _callNextPage();
    });
  }

  _callNextPage() async {
    if (await userRepo.internetInfo()) {
      Get.off(() => const OfflinePage());
    } else {
      if (DBService.to.getAccessToken().isNotEmpty) {
        Get.off(() => const HomePage());
      } else {
        Get.off(() => const LoginPage());
      }
    }
  }
}
