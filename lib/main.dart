import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:iteach/core/config/app_theme.dart';
import 'package:iteach/core/config/root_binding.dart';
import 'package:iteach/core/services/root_service.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/pages/parts/teacher/course_page/course_page.dart';
import 'package:iteach/feature/presentation/pages/parts/teacher/home_page/home_page.dart';
import 'package:iteach/feature/presentation/pages/login_page/login_page.dart';
import 'package:iteach/feature/presentation/pages/parts/teacher/teacher_page.dart';
import 'package:iteach/feature/presentation/pages/parts/teacher/profile_page.dart';
import 'package:iteach/feature/presentation/pages/splash_page.dart';
import 'package:iteach/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //DI
  di.init();

  //DB
  await RootService.init();

  //For system colors
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.bgColor, // Прозрачный цвет
      statusBarIconBrightness:
          Brightness.light, // Темные иконки (для светлого фона)
      systemNavigationBarColor:
          AppColors.bgColor, // Прозрачный цвет для нижней панели
      systemNavigationBarIconBrightness: Brightness.light, // Темные иконки
    ),
  );

  //APP
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      builder: (context, _) {
        return GetMaterialApp(
          title: 'Course App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          scrollBehavior: const ScrollBehavior().copyWith(
              overscroll: false, physics: const BouncingScrollPhysics()),
          initialBinding: RootBinding(),
          defaultTransition: Transition.native,
          transitionDuration: const Duration(milliseconds: 100),
          getPages: [
            GetPage(name: '/home', page: () => HomePage()),
            GetPage(name: '/teacher', page: () => TeacherPage()),
            GetPage(name: '/login', page: () => LoginPage()),
            GetPage(name: '/splash', page: () => SplashPage()),
            GetPage(name: '/course', page: () => CoursePage()),
            GetPage(name: '/profile', page: () => ProfilePage()),
          ],
          initialRoute: '/splash',
        );
      },
    );
  }
}
