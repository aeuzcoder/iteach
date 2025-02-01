import 'package:get/get.dart';
import 'package:iteach/feature/presentation/controllers/login_controller.dart';
import 'package:iteach/feature/presentation/controllers/splash_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
  }
}
