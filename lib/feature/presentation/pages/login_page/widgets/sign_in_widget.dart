// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/pages/login_page/widgets/text_field_widget.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    super.key,
    required this.usernameCtr,
    required this.passwordCtr,
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    required this.controllerH,
  });

  final TextEditingController usernameCtr;
  final TextEditingController passwordCtr;
  final GetxController controllerH;

  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;
  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    widget.usernameCtr.clear();
    widget.passwordCtr.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0.w),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            TextFieldWidget(
              title: 'Username',
              controller: widget.usernameCtr,
              isUsername: true,
              focusNode: widget.usernameFocusNode,
              controllerH: widget.controllerH,
            ),
            SizedBox(height: 24.h),
            TextFieldWidget(
              title: 'Password',
              controller: widget.passwordCtr,
              isPassword: true,
              focusNode: widget.passwordFocusNode,
              controllerH: widget.controllerH,
            ),
            SizedBox(height: 20.h),
            Text(
              'Parolni unutdingizmi?',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.widgetColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
