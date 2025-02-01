import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/domain/entities/user_entity.dart';
import 'package:iteach/feature/presentation/controllers/login_controller.dart';
import 'package:iteach/feature/presentation/pages/home_page/home_page.dart';
import 'package:iteach/feature/presentation/pages/login_page/widgets/app_bar_container.dart';
import 'package:iteach/feature/presentation/pages/login_page/widgets/sign_in_widget.dart';
import 'package:iteach/feature/presentation/pages/login_page/widgets/sign_up_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameCtr = TextEditingController();
  final passwordCtr = TextEditingController();
  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final addressCtr = TextEditingController();

  // Контроллер прокрутки
  final ScrollController _scrollController = ScrollController();

  // FocusNode для каждого поля ввода
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

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
    _nameFocusNode.addListener(() => _scrollToField(_nameFocusNode));
    _emailFocusNode.addListener(() => _scrollToField(_emailFocusNode));
    _addressFocusNode.addListener(() => _scrollToField(_addressFocusNode));
  }

  @override
  void dispose() {
    super.dispose();
    usernameCtr.dispose();
    passwordCtr.dispose();
    nameCtr.dispose();
    emailCtr.dispose();
    addressCtr.dispose();

    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // APP BAR CONTAINER
                AppBarContainer(
                  index: controller.indexItem,
                  function: (int index) => controller.changerItem(index),
                ),

                // TEXT FIELDS
                controller.indexItem == 0
                    ? SignInWidget(
                        usernameCtr: usernameCtr,
                        passwordCtr: passwordCtr,
                        usernameFocusNode: _usernameFocusNode,
                        passwordFocusNode: _passwordFocusNode,
                        controllerH: controller,
                      )
                    : SignUpWidget(
                        usernameCtr: usernameCtr,
                        nameCtr: nameCtr,
                        passwordCtr: passwordCtr,
                        emailCtr: emailCtr,
                        addressCtr: addressCtr,
                        nameFocusNode: _nameFocusNode,
                        usernameFocusNode: _usernameFocusNode,
                        passwordFocusNode: _passwordFocusNode,
                        emailFocusNode: _emailFocusNode,
                        addressFocusNode: _addressFocusNode,
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
                      if (controller.indexItem == 0 && controller.isValide) {
                        var isAuth = await controller.onSignIn(
                          username: usernameCtr.text,
                          password: passwordCtr.text,
                        );
                        if (isAuth) {
                          Get.offAll(() => HomePage());
                        }
                      } else if (controller.indexItem == 1 &&
                          controller.isValide) {
                        final UserEntity user = UserEntity(
                          name: nameCtr.text,
                          username: usernameCtr.text,
                          password: passwordCtr.text,
                          email: emailCtr.text,
                          address: addressCtr.text,
                        );
                        var isSignUp = await controller.onSignUp(user: user);
                        if (isSignUp) {
                          Get.snackbar(
                              'Xolat', 'Muvaffaqiyatli royhatga olindi');
                          controller.changerItem(0);
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
                                controller.indexItem == 0
                                    ? 'Sign In'
                                    : 'Sign Up',
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
        );
      },
    );
  }
}
