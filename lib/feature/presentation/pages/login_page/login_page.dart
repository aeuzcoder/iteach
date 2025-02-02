import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_assets.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/controllers/login_controller.dart';
import 'package:iteach/feature/presentation/pages/login_page/widgets/login_widget.dart';
import 'package:iteach/feature/presentation/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameCtr.dispose();
    passwordCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //LOGO
                  Container(
                    width: 180.w,
                    decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: AppColors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Image.asset(AppAssets.images.logo),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  // TEXT FIELD
                  LoginWidget(
                    usernameCtr: usernameCtr,
                    passwordCtr: passwordCtr,
                    controllerH: controller,
                  ),

                  // BUTTON
                  SizedBox(height: 20.h),
                  controller.errorOnPassword != null
                      ? Column(
                          children: [
                            Text(
                              controller.errorOnPassword!,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.widgetColor),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        )
                      : SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                    child: GestureDetector(
                      onTap: () async {
                        if (controller.isValide) {
                          var isAuth = await controller.onSignIn(
                            username: usernameCtr.text,
                            password: passwordCtr.text,
                          );
                          if (isAuth) {
                            Get.offAll(() => MainPage());
                          }
                        }
                      },
                      child: Container(
                        height: 52.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.widgetColor,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 4.r,
                              // ignore: deprecated_member_use
                              color: AppColors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: controller.isLoading
                              ? CircularProgressIndicator(
                                  color: AppColors.titleColor,
                                  strokeWidth: 2.r,
                                )
                              : Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
