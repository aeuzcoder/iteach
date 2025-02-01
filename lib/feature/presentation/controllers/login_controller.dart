import 'package:iteach/feature/data/datasources/database/db_service.dart';
import 'package:iteach/feature/presentation/controllers/base_controller.dart';

class LoginController extends BaseController {
  bool isValide = false;

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

  void checkerValide(bool isValidate) {
    isValide = isValidate;
    update();
  }

  Future<bool> onSignIn(
      {required String username, required String password}) async {
    errorOnPassword = null;
    changeLoading(true);
    final res = await userRepo.login(username: username, password: password);
    return res.fold(
      (error) {
        changeError(true, text: error);
        changeLoading(false);
        return false;
      },
      (signEntity) async {
        if (signEntity.accessToken.isNotEmpty) {
          await DBService.to.setAccessToken(signEntity.accessToken);
        }
        changeLoading(false);
        return true;
      },
    );
  }
}
