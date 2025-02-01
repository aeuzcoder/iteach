import 'package:get/get.dart';
import 'package:iteach/feature/domain/repository/user_repo.dart';
import 'package:iteach/service_locator.dart';

class BaseController extends GetxController {
  bool isLoading = false;
  bool isError = false;
  String errorText = '';
  final userRepo = sl<UserRepo>();

  void changeLoading(bool loading) {
    isLoading = loading;
    update();
  }

  void changeError(bool value, {String text = ''}) {
    isError = value;
    errorText = text;
    update();
  }
}
