import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iteach/core/errors/exception.dart';
import 'package:iteach/feature/data/datasources/database/db_service.dart';
import 'package:iteach/feature/data/models/user_model.dart';
import 'package:iteach/feature/presentation/controllers/base_controller.dart';

class ProfileController extends BaseController {
  UserModel? userInfo;
  bool isUploadImage = false;
  bool isEditing = false;
  bool isValide = false;
  bool isChanged = false;
  bool isLoading2 = false;
  final passwordCtr = TextEditingController();
  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final phoneCtr = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    passwordCtr.dispose();
    nameCtr.dispose();
    emailCtr.dispose();
    phoneCtr.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    changeLoading(true);
    userInfo = await getUser();
    if (userInfo != null && userInfo!.image != null) {
      isUploadImage = true;
    }
    changeLoading(false);
  }

  Future<UserModel?> getUser() async {
    var resultEither = await userRepo.getProfile();
    return resultEither.fold(
      (error) {
        changeError(true, text: error);
        return null;
      },
      (user) {
        return user;
      },
    );
  }

  Future<void> pickAndUploadPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    bool resOrErr = false;

    if (result != null) {
      File file = File(result.files.single.path!);
      changeLoading(true);
      var response = await userRepo.uploadImageOnProfile(file.path);
      response.fold(
        (error) {
          changeError(true, text: error);
          Get.snackbar('Xatolik', error);
          resOrErr = false;
        },
        (message) {
          Get.snackbar('Muvaffaqiyatli', 'Rasm yuklandi');
          resOrErr = true;
        },
      );
      changeLoading(false);
    }

    if (resOrErr) {
      changeLoading(true);
      userInfo = await getUser();

      isUploadImage = true;
    }
    changeLoading(false);
  }

  Future<String?> changeUser(UserModel user) async {
    changeLoading2(true);
    bool state = false;
    var response = await userRepo.updateProfile(user.toJson());
    response.fold(
      (error) {
        changeError(true, text: error);
        Get.snackbar('Xatolik', error);
        changeLoading(false);
        return null;
      },
      (message) {
        Get.snackbar('Muvaffaqiyatli', message);
        state = true;
        return message;
      },
    );
    if (state) {
      changeLoading2(false);
      editing(false);
      changeLoading(true);
      final response =
          await userRepo.login(username: user.email!, password: user.password!);
      if (response.isRight()) {
        final token = response.getOrElse(() => throw ServerException());
        await DBService.to.delAccessToken();
        await DBService.to.setAccessToken(token.accessToken);
      }

      userInfo = await getUser();

      changeLoading(false);
    } else {
      editing(false);

      changeLoading(false);
    }

    return null;
  }

  void checkInitialState() {
    if (passwordCtr.text.isNotEmpty &&
        nameCtr.text.isNotEmpty &&
        emailCtr.text.isNotEmpty &&
        phoneCtr.text.isNotEmpty) {
      isChanged = true;
      update();
    } else {
      isChanged = false;
      update();
    }
  }

  void changeState(bool state) {
    isChanged = state;
    update();
  }

  void checkerValide(bool isValidate) {
    isValide = isValidate;
    update();
  }

  void changeLoading2(bool state) {
    isLoading2 = state;
    update();
  }

  void editing(bool state) {
    isEditing = state;
    update();
  }

  Future<void> exitProfile() async {
    await DBService.to.delAccessToken();
    update();
  }
}
