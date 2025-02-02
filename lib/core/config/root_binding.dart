import 'package:get/get.dart';
import 'package:iteach/feature/presentation/controllers/course_controlller.dart';
import 'package:iteach/feature/presentation/controllers/home_controller.dart';
import 'package:iteach/feature/presentation/controllers/login_controller.dart';
import 'package:iteach/feature/presentation/controllers/main_controller.dart';
import 'package:iteach/feature/presentation/controllers/profile_controller.dart';
import 'package:iteach/feature/presentation/controllers/splash_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<CourseControlller>(() => CourseControlller(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.put<MainController>(MainController(), permanent: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
