import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/feature/presentation/pages/login_page/widgets/text_field_widget.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget(
      {super.key,
      required this.usernameCtr,
      required this.passwordCtr,
      required this.nameCtr,
      required this.emailCtr,
      required this.addressCtr,
      required this.nameFocusNode,
      required this.usernameFocusNode,
      required this.passwordFocusNode,
      required this.emailFocusNode,
      required this.addressFocusNode,
      required this.controllerH});

  final GetxController controllerH;
  final TextEditingController usernameCtr;
  final TextEditingController passwordCtr;
  final TextEditingController nameCtr;
  final TextEditingController emailCtr;
  final TextEditingController addressCtr;
  final FocusNode nameFocusNode;
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode addressFocusNode;
  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    widget.usernameCtr.clear();
    widget.nameCtr.clear();
    widget.emailCtr.clear();
    widget.addressCtr.clear();
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
            SizedBox(height: 12.h),
            TextFieldWidget(
              title: 'Ism',
              controller: widget.nameCtr,
              isName: true,
              focusNode: widget.nameFocusNode, // Передаем focusNode
              controllerH: widget.controllerH,
            ),
            SizedBox(
              height: 16.h,
            ),
            TextFieldWidget(
              title: 'Username',
              controller: widget.usernameCtr,
              isUsername: true,
              focusNode: widget.usernameFocusNode, // Передаем focusNode
              controllerH: widget.controllerH,
            ),
            SizedBox(
              height: 16.h,
            ),
            TextFieldWidget(
              title: 'Parol',
              controller: widget.passwordCtr,
              isPassword: true,
              focusNode: widget.passwordFocusNode, // Передаем focusNode
              controllerH: widget.controllerH,
            ),
            SizedBox(
              height: 16.h,
            ),
            TextFieldWidget(
              title: 'Email',
              controller: widget.emailCtr,
              isEmail: true,
              controllerH: widget.controllerH,
              focusNode: widget.emailFocusNode, // Передаем focusNode
            ),
            SizedBox(
              height: 16.h,
            ),
            TextFieldWidget(
              title: 'Manzil',
              controller: widget.addressCtr,
              isAddress: true,
              focusNode: widget.addressFocusNode, // Передаем focusNode
              controllerH: widget.controllerH,
            ),
            SizedBox(
              height: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}
