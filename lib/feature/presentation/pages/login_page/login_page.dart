import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/controllers/login_controller.dart';
import 'package:iteach/feature/presentation/pages/home_page/home_page.dart';
import 'package:iteach/feature/presentation/pages/login_page/widgets/login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  // Контроллер прокрутки
  final ScrollController _scrollController = ScrollController();

  // FocusNode для каждого поля ввода
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _scrollToField(FocusNode focusNode) {
    if (focusNode.hasFocus) {
      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() => _scrollToField(_usernameFocusNode));
    _passwordFocusNode.addListener(() => _scrollToField(_passwordFocusNode));
  }

  @override
  void dispose() {
    super.dispose();
    usernameCtr.dispose();
    passwordCtr.dispose();

    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200.h),
                  // TEXT FIELD
                  LoginWidget(
                    usernameCtr: usernameCtr,
                    passwordCtr: passwordCtr,
                    usernameFocusNode: _usernameFocusNode,
                    passwordFocusNode: _passwordFocusNode,
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
                                  fontSize: 16.sp, color: AppColors.red),
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
                            Get.offAll(() => HomePage());
                          }
                        }
                      },
                      child: Container(
                        height: 52.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.red,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 4.r,
                              // ignore: deprecated_member_use
                              color: AppColors.grey.withOpacity(0.6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: controller.isLoading
                              ? CircularProgressIndicator(
                                  color: AppColors.bgColor,
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
