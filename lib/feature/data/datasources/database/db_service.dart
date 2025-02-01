import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DBService {
  final GetStorage _box = GetStorage();

  static DBService get to => Get.find<DBService>();

  static Future<void> init() async {
    await Get.putAsync<DBService>(() async {
      final storageService = DBService();
      await GetStorage.init();
      return storageService;
    }, permanent: true);
  }

  bool isLoggedIn() {
    String token = getAccessToken();
    return token.isNotEmpty;
  }

  Future<void> logOut() async {
    await _box.erase(); // Clear all data on database DB
    await Get.deleteAll();
  }

  /// Access Token
  Future<void> setAccessToken(String? value) async {
    await _box.write(_StorageKeys.accessToken, value);
  }

  String getAccessToken() {
    return _box.read(_StorageKeys.accessToken) ?? "";
  }

  Future<void> delAccessToken() async {
    await _box.remove(_StorageKeys.accessToken);
  }

  /// Refresh Token
  Future<void> setRefreshToken(String? value) async {
    await _box.write(_StorageKeys.refreshToken, value);
  }

  String getRefreshToken() {
    return _box.read(_StorageKeys.refreshToken) ?? "";
  }

  Future<void> delRefreshToken() async {
    await _box.remove(_StorageKeys.refreshToken);
  }

  Future<void> setLanguage(String code) async {
    await _box.write(_StorageKeys.language, code);
  }

  /// User
  Future<void> setUser(String? value) async {
    await _box.write(_StorageKeys.user, value);
  }

  String getUser() {
    return _box.read(_StorageKeys.user) ?? "";
  }

  Future<void> delUser() async {
    await _box.remove(_StorageKeys.user);
  }

  /// Pin Code
  Future<void> setPinCode(String value) async {
    await _box.write(_StorageKeys.pinCode, value);
  }

  String getPinCode() {
    return _box.read(_StorageKeys.pinCode) ?? "";
  }

  /// Face/Touch ID
  Future<void> setBiometrics(bool value) async {
    await _box.write(_StorageKeys.biometrics, value);
  }

  bool getBiometrics() {
    return _box.read(_StorageKeys.biometrics) ?? false;
  }
}

class _StorageKeys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';

  static const language = 'language';
  static const user = 'user';
  static const pinCode = 'pin_code';
  static const biometrics = 'biometrics';
}
