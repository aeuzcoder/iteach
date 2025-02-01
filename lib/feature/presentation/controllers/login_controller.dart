import 'package:iteach/feature/data/datasources/database/db_service.dart';
import 'package:iteach/feature/domain/entities/user_entity.dart';
import 'package:iteach/feature/presentation/controllers/base_controller.dart';

class LoginController extends BaseController {
  bool isValide = false;

  int indexItem = 0;

  String? errorOnPassword;
  @override
  void onInit() {
    super.onInit();
    errorOnPassword = null;
    update();
  }

  void noError() {
    errorOnPassword = null;
    update();
  }

  void changerItem(int index) {
    indexItem = index;
    update();
  }

  void checkerValide(bool isValidate) {
    isValide = isValidate;
    update();
  }

  Future<bool> onSignIn(
      {required String username, required String password}) async {
    errorOnPassword = null;
    changeLoading(true);
    final res = await userRepo.signIn(username: username, password: password);

    if (res.isRight()) {
      var loginData = res.getOrElse(() => throw Exception("Unexpected error"));
      if (loginData.details != null) {
        errorOnPassword = loginData.details;
        update();
        changeLoading(false);
        return false;
      }
      if ((loginData.accessToken).isNotEmpty) {
        await DBService.to.setAccessToken(loginData.accessToken);
      }
      changeLoading(false);
      return true;
    }
    changeLoading(false);
    return false;
  }

  Future<bool> onSignUp({required UserEntity user}) async {
    changeLoading(true);
    final res = await userRepo.signUp(user: user);
    if (res.isRight()) {
      var loginData = res.getOrElse(() => throw Exception("Unexpected error"));

      if (loginData == 'User yaratildi.') {
        changeLoading(false);

        return true;
      } else {
        changeLoading(false);

        return false;
      }
    }
    changeLoading(false);

    return false;
  }
}
