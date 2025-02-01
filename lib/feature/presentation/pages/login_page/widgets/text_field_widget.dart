import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iteach/core/utils/app_colors.dart';
import 'package:iteach/feature/presentation/controllers/login_controller.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final bool isName;
  final bool isUsername;
  final bool isEmail;
  final bool isAddress;
  final bool isPassword;
  final TextEditingController controller;
  final FocusNode focusNode;
  final GetxController controllerH;

  const TextFieldWidget(
      {super.key,
      required this.title,
      required this.controller,
      this.isName = false,
      this.isUsername = false,
      this.isEmail = false,
      this.isAddress = false,
      this.isPassword = false,
      required this.focusNode,
      required this.controllerH});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  String? errorMessage;

  // Универсальная функция валидации
  String? validate(String value) {
    // Удаляем пробелы в начале и конце строки
    value = value.trim();

    if (widget.isName) {
      if (value.isEmpty) return 'Имя не должно быть пустым';
      if (!RegExp(r'^[a-zA-Zа-яА-Я]+$').hasMatch(value)) {
        return 'Имя должно содержать только буквы';
      }
    }

    if (widget.isUsername) {
      if (value.isEmpty) return 'Имя пользователя не должно быть пустым';
      if (value.contains(' ')) {
        return 'Имя пользователя не должно содержать пробелов';
      }
    }

    if (widget.isEmail) {
      if (value.isEmpty) return 'Email не должен быть пустым';
      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
        return 'Введите корректный Email';
      }
    }

    if (widget.isAddress) {
      if (value.isEmpty) return 'Адрес не должен быть пустым';
    }

    if (widget.isPassword) {
      if (value.isEmpty) return 'Пароль не должен быть пустым';
      if (value.length < 6) {
        return 'Пароль должен содержать не менее 6 символов';
      }
    }

    return null; // Нет ошибок
  }

  // Метод для проверки валидности

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: widget.focusNode,
          onTapOutside: (tab) => FocusScope.of(context).unfocus(),
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.title,
            labelStyle: TextStyle(
              color: AppColors.blvk02,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            errorText: errorMessage,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.blvk01),
            ),
          ),
          style: TextStyle(
            decorationColor: AppColors.bgColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          onChanged: (value) {
            // Обновляем состояние с ошибкой
            setState(() {
              errorMessage = validate(value);
              if (widget.controllerH is LoginController) {
                if (errorMessage == null) {
                  ((widget.controllerH) as LoginController).checkerValide(true);
                } else {
                  ((widget.controllerH) as LoginController)
                      .checkerValide(false);
                }
              }
            });
          },
        ),
      ],
    );
  }
}
